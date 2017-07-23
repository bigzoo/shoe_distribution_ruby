require("spec_helper")

describe(Sale)do
  describe("#active_record_stuff")do
    it("It adds sales") do
      store1 = Store.create(name:"Bata",location:"Nairobi",owner:"Mike Bata")
      store2 = Store.create(name:"Yaya",location:"Nairobi",owner:"Mike Yaya")
      brand1 = Brand.create(name:"Yeezy 350", release_date:Date.new(2016,1,15),manufacturer:"Adidas")
      brand2 = Brand.create(name:"Yeezy 400", release_date:Date.new(2017,1,15),manufacturer:"Adidas")
      sale1 = Sale.create(store_id:store1.id,brand_id:brand1.id,price:"5000",stock:10)
      sale2 = Sale.create(store_id:store2.id,brand_id:brand1.id,price:"6000",stock:1)
      sale3 = Sale.create(store_id:store2.id,brand_id:brand2.id,price:"6000",stock:2)
      expect(store1.sales).to(eq([sale1]))
      expect(store2.sales).to(eq([sale2,sale3]))
      expect(brand1.stores).to(eq([store1,store2]))
      expect(brand2.stores).to(eq([store2]))
      expect(sale1.brand).to(eq(brand1))
      expect(brand1.sales).to(eq([sale1,sale2]))
      Sale.where(store_id: store1.id).destroy_all
      expect(Sale.all).to(eq([sale2,sale3]))
    end
  end
end
