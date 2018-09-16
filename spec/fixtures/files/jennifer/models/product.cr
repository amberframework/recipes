class Product < ApplicationRecord
  with_timestamps

  mapping(
    id: Primary32,
    title: {type: String?},
    description: {type: String?},
    category_id: {type: Int32?},
    user_id: {type: String?},
    created_at: {type: Time?},
    updated_at: {type: Time?},
  )

  belongs_to :category, Category
end
