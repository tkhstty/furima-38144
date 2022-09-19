class AddDeliveryDurationIdToItems < ActiveRecord::Migration[6.0]
  def change
    add_column :items, :delivery_duration_id, :integer
  end
end
