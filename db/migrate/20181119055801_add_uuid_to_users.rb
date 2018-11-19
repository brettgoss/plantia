class AddUuidToUsers < ActiveRecord::Migration[5.2]
  def self.up
    enable_extension "pgcrypto" unless extension_enabled?("pgcrypto")
    add_column :users, :uuid, :uuid, default: 'gen_random_uuid()'
  end

  def self.down
    disable_extension "pgcrypto"
    remove_column :users, :uuid
  end
end
