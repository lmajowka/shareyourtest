class AddPictureToExams < ActiveRecord::Migration
    def self.up
      add_attachment :exams, :picture
    end

    def self.down
      remove_attachment :exams, :picture
    end
end
