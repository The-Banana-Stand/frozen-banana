class AddAttachmentAttachmentToInvites < ActiveRecord::Migration[5.1]
  def self.up
    change_table :invites do |t|
      t.attachment :attachment
    end
  end

  def self.down
    remove_attachment :invites, :attachment
  end
end
