class Datasets::LicencesController < ApplicationController
  before_action :authenticate_user!

  def new
    @dataset = current_dataset
  end

  def edit
    @dataset = current_dataset
  end

  def create
    @dataset = current_dataset
    @dataset.update_attributes(params.fetch(:dataset, {}).permit(:licence_code))

    if @dataset.save(context: :dataset_form)
      redirect_to new_dataset_location_path(@dataset.uuid, @dataset.name)
    else
      render :new
    end
  end

  def update
    @dataset = current_dataset
    @dataset.update_attributes(params.require(:dataset).permit(:licence_code))

    if @dataset.save(context: :dataset_form)
      redirect_to dataset_path(@dataset.uuid, @dataset.name)
    else
      render :edit
    end
  end

private

  def current_dataset
    Dataset.find_by(uuid: params[:uuid])
  end
end
