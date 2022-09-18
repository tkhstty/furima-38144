class AddDeliveryChargeIdToItems < ActiveRecord::Migration[6.0]
  def change
    add_column :items, :delivery_charge_id, :integer
  end
end
