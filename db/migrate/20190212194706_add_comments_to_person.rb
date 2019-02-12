class AddCommentsToPerson < ActiveRecord::Migration[5.2]
  def change
    change_column :people, "given_name", :string, comment: "The person's first/given name" 
    change_column :people, "family_name", :string, comment: "The person's last/family name"
    change_column :people, "additional_name", :string, comment: "Any additional name"
    change_column :people, "honorific_prefix", :string, comment: "Name prefix"
    change_column :people, "honorific_suffix", :string, comment: "name suffix"
    change_column :people, "nickname", :string, comment: "Any nickname the person prefers"
    change_column :people, "full_name", :string, comment: "Full name, typically given + family"
    change_column :people, "shirt_size", :string, comment: "Shirt size preference"
    change_column :people, "dietary_note", :text, comment: "Any dietary restrictions or preferences"
  end
end
