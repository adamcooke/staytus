class AddPrivacyPolicyUrlToSites < ActiveRecord::Migration[5.1]
  def change
    add_column :sites, :privacy_policy_url, :string
  end
end
