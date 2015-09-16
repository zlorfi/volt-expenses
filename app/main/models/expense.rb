class Expense < Volt::Model
  own_by_user

  field :description, String
  field :amount, Numeric
  field :created_at, Time

  belongs_to :user
  belongs_to :category

  validate :description, length: 2
  validate :amount, numericality: true
  # validate :category, presence: true

  permissions(:update, :delete) do
    # Only the person who created the post can delete or update it
    deny unless owner?
  end

end
