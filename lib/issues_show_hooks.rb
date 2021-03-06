class IssuesShowHooks < Redmine::Hook::ViewListener
  def view_projects_show_left(context = { })
    project = context[:project]
    if project.enabled_modules.map(&:name).include? "redmine_blocks_layout"
      if  OverviewBlock.find_by_project_id_and_name(project,'issues')
        if context[:hook_caller].respond_to?(:render)
          context[:hook_caller].send(:render, {:locals => context, :partial => '/projects/issues'})
        elsif context[:controller].is_a?(ActionController::Base)
          context[:controller].send(:render_to_string, {:locals => context, :partial => '/projects/issues'})
        end
      end
    else

      context[:hook_caller].send(:render, {:locals => context, :partial => '/projects/issues'}) if context[:hook_caller].respond_to?(:render)
    end
  end
end

