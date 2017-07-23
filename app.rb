require('bundler/setup')
Bundler.require(:default)
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }
also_reload('lib/**/*.rb')

get('/')do
  @brands = Brand.all
  @stores = Store.all
  @sales = Sale.all
  erb(:index)
end

get('/stores')do
  @stores = Store.all
  erb(:stores)
end

get('/brands')do
  @brands = Brand.all
  erb(:brands)
end

get('/stores/:id')do
  @store = Store.find(params.fetch('id').to_i)
  @brands = Brand.all
  erb(:store)
end

get('/brands/:id')do
  @brands = Brand.all
  @brand = Brand.find(params.fetch('id').to_i)
  erb(:brand)
end

get('/stores/:id/delete/brands')do
  @store = Store.find(params.fetch('id').to_i)
  Sale.where(store_id: @store.id).destroy_all
  redirect('/stores')
end

get('/brands/:id/delete/sales')do
  brand = Brand.find(params.fetch('id').to_i)
  Sale.where(brand_id: brand.id).destroy_all
  redirect('/brands')
end

get('/brands/:brand_id/delete/sales/:id')do
  sale = Sale.find(params.fetch('id').to_i)
  Sale.destroy(sale.id)
  redirect('/brands/'.concat(params.fetch('brand_id')))
end

get('/stores/delete/:id')do
  store = Store.find(params.fetch('id').to_i)
  Sale.where(store_id: store.id).destroy_all
  Store.destroy(store.id)
  redirect('/stores')
end

get('/brands/delete/:id')do
  brand = Brand.find(params.fetch('id').to_i)
  Sale.where(brand_id: brand.id).destroy_all
  Brand.destroy(brand.id)
  redirect('/brands')
end

post('/stores')do
  store_name = params.fetch('name')
  store_location = params.fetch('location')
  store_owner = params.fetch('owner')
  store_image = params.fetch('image_url')
  new_store = Store.new(name:store_name,location:store_location,owner:store_owner,image_url:store_image)
  new_store.save
  redirect('/stores')
end

patch('/stores/:id')do
  store = Store.find(params.fetch('id').to_i)
  store_name = params.fetch('name')
  if store_name==''
    store_name=store.name
  end
  store_location = params.fetch('location')
  if store_location==''
    store_location=store.location
  end
  store_owner = params.fetch('owner')
  if store_owner==''
    store_owner=store.owner
  end
  store_image = params.fetch('image_url')
  if store_image==''
    store_image=store.image_url
  end
  store.update(name:store_name,location:store_location,owner:store_owner,image_url:store_image)
  redirect('/stores/'.concat(params.fetch('id')))
end

patch('/brands/:id')do
  brand = Brand.find(params.fetch('id').to_i)
  brand_name = params.fetch('name')
  if brand_name==''
    brand_name=brand.name
  end
  brand_manufacturer = params.fetch('manufacturer')
  if brand_manufacturer==''
    brand_manufacturer=brand.manufacturer
  end
  brand_rel_date = params.fetch('release_date')
  if brand_rel_date==''
    brand_rel_date=brand.release_date
  end
  brand_image = params.fetch('image_url')
  if brand_image==''
    brand_image=brand.image_url
  end
  brand.update(name:brand_name,manufacturer:brand_manufacturer,release_date:brand_rel_date,image_url:brand_image)
  redirect('/brands/'.concat(params.fetch('id')))
end

patch('/sales')do
  sale = Sale.find(params.fetch('sale_id').to_i)
  sale_price = params.fetch('price')
  if sale_price==''
    sale_price = sale.price
  end
  sale_stock = params.fetch('stock')
  if sale_stock==''
    sale_stock=sale.stock
  end
  sale.update(price:sale_price,stock:sale_stock)
  redirect('/brands/'.concat(sale.brand.id.to_s))
end

post('/brands')do
  brand_name = params.fetch('name')
  brand_manufacturer = params.fetch('manufacturer')
  brand_rel_date = params.fetch('release_date')
  brand_image = params.fetch('image_url')
  new_brand = Brand.new(name:brand_name,manufacturer:brand_manufacturer,release_date:brand_rel_date,image_url:brand_image)
  new_brand.save
  redirect('/brands')
end

post('/sales')do
  new_sale_store = params.fetch('store_id')
  new_sale_brand = params.fetch('brand_id')
  new_sale_price = params.fetch('price')
  new_sale_stock = params.fetch('stock')
  new_sale = Sale.new(store_id:new_sale_store,brand_id:new_sale_brand,price:new_sale_price,stock:new_sale_stock)
  new_sale.save
  redirect('/stores/'.concat(new_sale_store))
end
