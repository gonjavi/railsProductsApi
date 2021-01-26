class ProductSerializer
  include FastJsonapi::ObjectSerializer
  attributes :product_name, :seller
end
