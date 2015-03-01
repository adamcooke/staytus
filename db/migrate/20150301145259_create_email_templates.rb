class CreateEmailTemplates < ActiveRecord::Migration
  def change
    create_table :email_templates do |t|
      t.string :name, :subject
      t.text :content
      t.timestamps null: false
    end
  end
end
