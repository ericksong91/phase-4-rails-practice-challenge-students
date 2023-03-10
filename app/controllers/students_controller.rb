class StudentsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

    def index
        students = Student.all
        render json: students
    end

    def show
        student = Student.find(student_find)
        render json: student
    end

    def create
        student = Student.create(student_params)
        render json: student, status: :created
    end

    def destroy
        student = Student.find(student_find)
        student.destroy
        head :no_content
    end

    private 

    def student_find
        params[:id]
    end

    def student_params
        params.permit(:name, :age, :major, :instructor_id)
    end

    def render_not_found_response
        render json: { error: "Student not found" }, status: :not_found
    end

    def render_unprocessable_entity_response(exception)
        render json: { error: exception.record.errors.full_messages }, status: :unprocessable_entity
    end
end
