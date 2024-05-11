class CmsController < ApplicationController
  before_action :token_authenticate_admin_user!
  before_action :set_paper_trail_whodunnit
  
  def create
    ActiveRecord::Base.transaction do
      @object = controller_name.classify.constantize.new create_params
      if @object.save!
        if params[:images].present? && @object.respond_to?(:images)
          params[:images].each_with_index do |image_attr, index|
            image = Image.find image_attr[:id]
            image.update target: @object, ranking: 100 - index
          end
        end
        operation_success
      else
        operation_failed(@object.errors.full_messages.join(","))
      end
    end
  end

  def update
    ActiveRecord::Base.transaction do
      if @object.update! update_params
        if params[:images].present? && @object.respond_to?(:images)
          @object.images.update_all target_type: nil, target_id: nil
          params[:images].each_with_index do |image_attr, index|
            image = Image.find image_attr[:id]
            image.update target: @object, ranking: 100 - index
          end
        elsif params[:images]&.empty?
          @object.images.update_all target_type: nil, target_id: nil
        end

        operation_success
      else
        operation_failed(@object.errors.full_messages.join(","))
      end
    end
  end

  def show
  end

  def destroy
    if @object.respond_to?(:check_dependence!)
      @object.destroy if @object.check_dependence!
    else
      @object.destroy
    end
    operation_success
  end
  
  private
  def load_object
    @object = controller_name.classify.constantize.with_deleted.find params[:id]
  end

  def load_objects
    @objects = controller_name.classify.constantize.with_deleted.where(id: params[:ids])
  end

  def user_for_paper_trail
    "0#{current_admin_user.name}(#{current_admin_user.id})"
  end
end
