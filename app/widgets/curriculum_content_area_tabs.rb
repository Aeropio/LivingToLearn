class CurriculumContentAreaTabs < Netzke::Basepack::TabPanel

  def configuration
    config = {
      :items => [{
        :title => "List",
        :class_name => "::CurriculumContentAreasGrid"
      }]
    }

    if ( record_id =  ::Netzke::Core.controller.params[:id])
      config[:items][1] = {
        :record_id => record_id,
        :title => "Detail",
        :class_name => "::CurriculumContentAreaForm"
      }
      config[:active_tab] = 1
    else
      config[:active_tab] = 0
    end

    c = super.merge(config)
  end

end

