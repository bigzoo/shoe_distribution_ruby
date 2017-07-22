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
  @brands = Brand.all
  @stores = Store.all
  @sales = Sale.all
  erb(:stores)
end

get('/brands')do
  erb(:brands)
end

post('/stores')do
  store_name = params.fetch('name')
  store_location = params.fetch('location')
  store_owner = params.fetch('owner')
  store_image = params.fetch('image_url')
  new_store = Store.new(name:store_name,location:store_location,owner:store_owner,image_url:store_image)
  new_store.save
  redirect('/')
end
