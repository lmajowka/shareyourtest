class EmbeddablesController < ApplicationController

  def create
    if current_user.admin?
      exam_category = ExamCategory.find_by_permalink params[:exam_category_id]
      embeddable = exam_category.embeddables.new(params.require(:embeddable).permit(:content,:title))
      if embeddable.save
        render 'new'
      else
        render 'new'
      end
    end
  end

end
