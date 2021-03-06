require 'dry-validation'

class CustomerValidator
  SCHEMA = Dry::Validation.Schema do
    required(:name).filled(:str?)
    required(:user_id).filled(:int?, gt?: 0)
    required(:latitude) { filled? & (int? | float?) & gteq?(-90) & lteq?(90) }
    required(:longitude) { filled? & (int? | float?) & gteq?(-180) & lteq?(180) }
  end

  def self.call(customer)
    SCHEMA.call(customer).success?
  end
end