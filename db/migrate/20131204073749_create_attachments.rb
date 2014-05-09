class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.string :file_name
      t.binary :file_url
      t.integer :project_id

      t.timestamps
    end
  end
end
