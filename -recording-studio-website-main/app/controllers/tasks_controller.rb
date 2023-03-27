# frozen_string_literal: true

class TasksController < ApplicationController
  before_action :set_task, only: %i[show edit update destroy complete uncomplete complete_in_subj uncomplete_in_subj complete_in_deadline return_done]

  # GET /tasks
  # GET /tasks.json
  def index
    @tasks = Task.all
    @completed_tasks = Task.where(status: true).where(hidden: false).order('updated_at')
    @uncompleted_tasks = Task.where(status: false).order('created_at')
    @cleared_tasks = Task.where(hidden: true).order('updates_at')
  end

  def index_subj
    @tasks = Task.where(hidden: false).order('subj').order('status')
    # @uncompleted_tasks = Task.where(status: false).order('subj')
    # @completed_tasks = Task.where(status: true).where(hidden: false).order('subj')
  end

  def index_deadline
    @uncompleted_tasks = Task.where(status: false).order('deadline')
  end

  def index_cleared
    @cleared_tasks = Task.where(hidden: true).order('updated_at')
  end

  def index_all
    @tasks = Task.all
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show; end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit; end

  # POST /tasks
  # POST /tasks.json
  def create
    if user_signed_in?
      @task = current_user.tasks.new(task_params)
      respond_to do |format|
        if @task.save
          format.html { redirect_to @task, notice: 'Задача успешно создана.' }
          format.json { render :show, status: :created, location: @task }
        else
          format.html { render :new }
          format.json { render json: @task.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to new_user_session_path
    end
  end

  def index_your
    if user_signed_in?
      @completed_tasks = current_user.tasks.all.where(status: true)
      @uncompleted_tasks = current_user.tasks.all.where(status: false)
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, notice: 'Задача успешно обновлена.' }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: 'Задача успешно удалена.' }
      format.json { head :no_content }
    end
  end

  def complete
    @task.complete!
    redirect_to tasks_path
  end

  def uncomplete
    @task.uncomplete!
    redirect_to tasks_path
  end

  def complete_in_subj
    @task.complete!
    redirect_to tasks_index_subj_path
  end

  def uncomplete_in_subj
    @task.uncomplete!
    redirect_to tasks_index_subj_path
  end

  def complete_in_deadline
    @task.complete!
    redirect_to tasks_index_deadline_path
  end

  def destroy_all_done
    @cleared_tasks = Task.where(status: true).where(hidden: true).order('updated_at')
    @cleared_tasks.each(&:destroy)
    redirect_to tasks_path, notice: 'Выполненные задачи успешно удалены.'
  end

  def clear_all_done
    # @cleared_tasks = Task.where(hidden: true).order('updates_at')
    @completed_tasks = Task.where(status: true).order('updated_at')
    @completed_tasks.each(&:clear!)
    redirect_to tasks_path, notice: 'Выполненные задачи перемещены в архив завершенных.'
  end

  def return_done
    @task.un_clear!
    redirect_to tasks_index_cleared_path
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

    def task_params
    params.require(:task).permit(:subj, :descript, :status, :user_id, :deadline, :hidden)
  end
end
