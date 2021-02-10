class CategorySerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :product_id
end
