class Listing < ActiveRecord::Base
  belongs_to :user

  acts_as_workflow name: :buyer, version: :last

  validate_with_custom_logic do
    def condition_1
      true
    end

    def condition_2
      true
    end

    def condition_3
      true
    end
  end
end
