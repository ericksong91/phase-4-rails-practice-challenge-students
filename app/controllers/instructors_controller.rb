class InstructorsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

    def index
        instructors = Instructor.all 
        render json: instructors
    end

    def show
        instructor = Instructor.find(instructor_find)
        render json: instructor
    end

    def create
        instructor = Instructor.create(instructor_params)
        render json: instructor, status: :created
    end

    def destroy
        instructor = Instructor.find(instructor_find)
        instructor.destroy
        head :no_content
    end

    private

    def instructor_find
        params[:id]
    end

    def instructor_params
        params.permit(:name)
    end

    def render_not_found_response
        render json: { error: "Instructor not found" }, status: :not_found
    end

    def render_unprocessable_entity_response(exception)
        render json: { error: exception.record.errors.full_messages }, status: :unprocessable_entity
    end
end
