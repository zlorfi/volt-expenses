class Category < Volt::Model
  field :name, String

  validate :name, length: 2
  validate :name, presence: true
end
