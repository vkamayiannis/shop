class Item < ActiveRecord::Base
	belongs_to :category
	validates :code, :presence => true, :uniqueness => true
	validates :description, :presence => true 
	has_attached_file :uploaded_file, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/notfound.png"
	validates_attachment_content_type :uploaded_file, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

	def self.search(keyword)
		if keyword.present?
			where('description like ?', "%#{keyword}%")
		else
			all
		end
	end

	def self.filter(category_id)
		if category_id.present?
			where('category_id = ?', category_id)
		end
	end

	def self.import(file)
		CSV.foreach(file.path, headers: true) do |row|
			Item.create!(row.to_hash)
		end
	end

	def self.to_csv(options = {})
		CSV.generate(options) do |csv|
			csv << column_names
			all.each do |item|
				csv << item.attributes.values_at(*column_names)
			end
		end
	end
end
