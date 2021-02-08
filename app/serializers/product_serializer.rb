class ProductSerializer
  include FastJsonapi::ObjectSerializer
  attributes :product_name, :seller, :user_id
end
