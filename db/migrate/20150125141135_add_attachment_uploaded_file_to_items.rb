class AddAttachmentUploadedFileToItems < ActiveRecord::Migration
  def self.up
    change_table :items do |t|
      t.attachment :uploaded_file
    end
  end

  def self.down
    remove_attachment :items, :uploaded_file
  end
end
