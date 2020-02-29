class CreateFollowRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :follow_requests do |t|
      t.boolean :status
      t.integer :sender_id
      t.integer :recipient_id

      t.timestamps
    end
  end
end
