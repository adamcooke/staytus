class CreateNiftyAttachmentsTable < ActiveRecord::Migration
  
  def up
    create_table :nifty_attachments do |t|
      t.integer :parent_id
      t.string  :parent_type, :token, :digest, :role, :file_name, :file_type
      t.binary :data, :limit => 10.megabytes
      t.timestamps
    end
  end
  
  def down
    drop_table :nifty_attachments
  end
  
end