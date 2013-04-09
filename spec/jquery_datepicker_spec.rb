require 'pp'
require 'spec_helper'
require 'app/helpers/datepicker_helper'
require 'app/helpers/form_helper'
require 'date'

ActionView::Base.send(:include, JqueryDatepicker::DatepickerHelper)
ActionView::Helpers::FormBuilder.send(:include,JqueryDatepicker::FormBuilder)

current_value = Time.new(2002, 10, 31, 14, 2, 3, "+02:00")
current_value_date = Date.new(2002, 10, 31)

describe JqueryDatepicker do

   let :valid_nested_response_input do
      "<input id=\"foo_var_att1\" name=\"foo[var][att1]\" size=\"30\" type=\"text\" />"
    end

    let :valid_nested_response_javascript do
      "<script type=\"text/javascript\">\n//<![CDATA[\njQuery(document).ready(function(){jQuery('#foo_var_att1').datepicker({})});\n//]]>\n</script>"
    end

    let :valid_response_input do
      "<input id=\"foo_att1\" name=\"foo[att1]\" size=\"30\" type=\"text\" />"
    end

    let :valid_response_javascript do
      "<script type=\"text/javascript\">\n//<![CDATA[\njQuery(document).ready(function(){jQuery('#foo_att1').datepicker({})});\n//]]>\n</script>"
    end

    let :valid_response_javascript_datetime do
      "<script type=\"text/javascript\">\n//<![CDATA[\njQuery(document).ready(function(){jQuery('#foo_att1').datetimepicker({})});\n//]]>\n</script>"
    end

  describe JqueryDatepicker::DatepickerHelper, :type => :view do

    let :datepicker_input_template do
        <<-EOTEMPLATE
          <%= datepicker_input(:foo, :att1) %>
        EOTEMPLATE
    end

    let :datetimepicker_input_template do
        <<-EOTEMPLATE
          <%= datetime_picker_input(:foo, :att1) %>
        EOTEMPLATE
    end

    let :datepicker_input_dp_options_template do
        <<-EOTEMPLATE
          <%= datepicker_input(:foo, :att1, :dateFormat  => "yy-mm-dd", :minDate => -20, :maxDate => "+1M +10D") %>
        EOTEMPLATE
    end

    let :datepicker_input_tf_options_template do
        <<-EOTEMPLATE
          <%= datepicker_input(:foo, :att1, :tabindex => 70) %>
        EOTEMPLATE
    end

    let :datepicker_input_tf_and_dp_options_template do
        <<-EOTEMPLATE
          <%= datepicker_input(:foo, :att1, :dateFormat  => "yy-mm-dd", :minDate => -20, :maxDate => "+1M +10D", :tabindex => 70) %>
        EOTEMPLATE
    end

    let :datepicker_input_dateFormat_template do
        <<-EOTEMPLATE
          <%= datepicker_input(:foo, :att1, :dateFormat  => "yy-mm-dd", :minDate => -20, :maxDate => "+1M +10D", :value => "#{current_value.to_s}") %>
        EOTEMPLATE
    end

   let :datepicker_input_dateFormat_template_date do
        <<-EOTEMPLATE
          <%= datepicker_input(:foo, :att1, :dateFormat  => "yy-mm-dd", :minDate => -20, :maxDate => "+1M +10D", :value => "#{current_value_date.to_s}") %>
        EOTEMPLATE
    end

    let :datepicker_input_dateFormat_M_template_date do
          <<-EOTEMPLATE
            <%= datepicker_input(:foo, :att1, :dateFormat  => "dd M yy", :minDate => -20, :maxDate => "+1M +10D", :value => "#{current_value_date.to_s}") %>
          EOTEMPLATE
    end

    let :datepicker_input_dateFormat_dmY_template_date do
          <<-EOTEMPLATE
            <%= datepicker_input(:foo, :att1, :dateFormat  => "m/d/y", :minDate => -20, :maxDate => "+1M +10D", :value => "#{current_value_date.to_s}") %>
          EOTEMPLATE
    end

    let :datepicker_input_with_value_template do
        <<-EOTEMPLATE
          <%= datepicker_input(:foo, :att1, :value => "#{current_value.to_s}") %>
        EOTEMPLATE
    end

    let :datepicker_input_with_options_with_empty_value_template do
        <<-EOTEMPLATE
          <%= datepicker_input(:foo, :att1, :tabindex => 70, :minDate => -20, :maxDate => "+1M +10D", :dateFormat => "yy-mm-dd", :value => "") %>
        EOTEMPLATE
    end

    let :valid_response_javascript_with_options do
      "<script type=\"text/javascript\">\n//<![CDATA[\njQuery(document).ready(function(){jQuery('#foo_att1').datepicker({\"dateFormat\":\"yy-mm-dd\",\"maxDate\":\"+1M +10D\",\"minDate\":-20})});\n//]]>\n</script>"
    end

    let :valid_response_javascript_with_options_M do
      "<script type=\"text/javascript\">\n//<![CDATA[\njQuery(document).ready(function(){jQuery('#foo_att1').datepicker({\"dateFormat\":\"dd M yy\",\"maxDate\":\"+1M +10D\",\"minDate\":-20})});\n//]]>\n</script>"
    end

    let :valid_response_javascript_with_options_dmY do
      "<script type=\"text/javascript\">\n//<![CDATA[\njQuery(document).ready(function(){jQuery('#foo_att1').datepicker({\"dateFormat\":\"m/d/y\",\"maxDate\":\"+1M +10D\",\"minDate\":-20})});\n//]]>\n</script>"
    end

    let :valid_response_input_with_options do
      "<input id=\"foo_att1\" name=\"foo[att1]\" size=\"30\" tabindex=\"70\" type=\"text\" />"
    end

    let :valid_response_input_with_options_empty do
      "<input id=\"foo_att1\" name=\"foo[att1]\" size=\"30\" tabindex=\"70\" type=\"text\" value=\"\" />"
    end

    let :valid_response_input_with_value do
      "<input id=\"foo_att1\" name=\"foo[att1]\" size=\"30\" type=\"text\" value=\"#{current_value.to_s}\" />"
    end

    let :valid_response_input_with_value_formatted do
      "<input id=\"foo_att1\" name=\"foo[att1]\" size=\"30\" type=\"text\" value=\"#{current_value.strftime('%Y-%m-%d')}\" />"
    end

    let :valid_response_input_with_value_formatted_M do
      "<input id=\"foo_att1\" name=\"foo[att1]\" size=\"30\" type=\"text\" value=\"#{current_value.strftime('%d %b %Y')}\" />"
    end

    let :valid_response_input_with_value_formatted_dmY do
      "<input id=\"foo_att1\" name=\"foo[att1]\" size=\"30\" type=\"text\" value=\"#{current_value.strftime('%-m/%-d/%y')}\" />"
    end

    it "should return a valid code when calling from the helper" do
      render :inline => datepicker_input_template
      rendered.strip.should == valid_response_input+valid_response_javascript
    end

    it "should use the jQuery datepicker options" do
      render :inline => datepicker_input_dp_options_template
      rendered.strip.should == valid_response_input+valid_response_javascript_with_options
    end

    it "should use the text_field options" do
      render :inline => datepicker_input_tf_options_template
      rendered.strip.should == valid_response_input_with_options+valid_response_javascript
    end

    it "should use populate the default value when sending a Date.to_s" do
      render :inline => datepicker_input_dateFormat_template_date
      rendered.strip.should == valid_response_input_with_value_formatted+valid_response_javascript_with_options
    end

    it "should put each option on the correct place when sending Datepicker and textfield options" do
      render :inline => datepicker_input_tf_and_dp_options_template
      rendered.strip.should == valid_response_input_with_options+valid_response_javascript_with_options
    end

    it "should work when sending the value on the options" do
      render :inline => datepicker_input_with_value_template
      rendered.strip.should == valid_response_input_with_value+valid_response_javascript
    end

    it "should format the date if both dateFormat and value params are set" do
      render :inline => datepicker_input_dateFormat_template
      rendered.strip.should == valid_response_input_with_value_formatted+valid_response_javascript_with_options
    end

    it "should format the date if both dateFormat and value params are set M" do
      render :inline => datepicker_input_dateFormat_M_template_date
      rendered.strip.should == valid_response_input_with_value_formatted_M+valid_response_javascript_with_options_M
    end

    it "should format the date if both dateFormat and value params are set m/d/Y" do
      render :inline => datepicker_input_dateFormat_dmY_template_date
      rendered.strip.should == valid_response_input_with_value_formatted_dmY+valid_response_javascript_with_options_dmY
    end

    it "should render empty default value, but format the date if format options are sent but value is nil" do
      render :inline => datepicker_input_with_options_with_empty_value_template
      rendered.strip.should == valid_response_input_with_options_empty+valid_response_javascript_with_options
    end

  end

  describe JqueryDatepicker::FormHelper, :type => :view do

    let :foo do
      Foo.new(current_value_date, current_value)
    end

    let :datepicker_form_template do
        <<-EOTEMPLATE
          <%= form_for(foo, :url => "fake") do |f| %>
            <%= f.datepicker(:att1) %>
          <% end %>
        EOTEMPLATE
    end

    let :datetimepicker_form_template do
        <<-EOTEMPLATE
          <%= form_for(foo, :url => "fake") do |f| %>
            <%= f.datetime_picker(:att1) %>
          <% end %>
        EOTEMPLATE
    end

    let :datepicker_nested_form_template do
        <<-EOTEMPLATE
          <%= form_for(foo, :url => "fake") do |f| %>
            <%= f.fields_for :var do |f2| %>
              <%= f2.datepicker(:att1) %>
            <% end %>
          <% end %>
        EOTEMPLATE
    end

    let :datepicker_form_template_current do
      <<-EOTEMPLATE
        <%= form_for(foo, :url => "fake") do |f| %>
          <%= f.datepicker(:att_date, :dateFormat => "dd/mm/yy") %>
        <% end %>
      EOTEMPLATE
    end

    let :datetimepicker_form_template_current_12 do
      <<-EOTEMPLATE
        <%= form_for(foo, :url => "fake") do |f| %>
          <%= f.datetime_picker(:att_time, :dateFormat => "dd/mm/yy", :timeFormat => "hh:mmtt") %>
        <% end %>
      EOTEMPLATE
    end

    let :datetimepicker_form_template_current_24 do
      <<-EOTEMPLATE
        <%= form_for(foo, :url => "fake") do |f| %>
          <%= f.datetime_picker(:att_time, :dateFormat => "dd/mm/yy", :timeFormat => "HH:mm") %>
        <% end %>
      EOTEMPLATE
    end

    it "should return a valid response when calling inside a form_for" do
      render :inline => datepicker_form_template , :locals => {:foo => foo}
      rendered.should include(valid_response_input)
      rendered.should include(valid_response_javascript)
    end

    it "should return a valid datetime response when calling inside a form_for" do
      render :inline => datetimepicker_form_template , :locals => {:foo => foo}
      rendered.should include(valid_response_input)
      rendered.should include(valid_response_javascript_datetime)
    end

    it "should return a valid response when calling inside a nested form_form" do
      render :inline => datepicker_nested_form_template,:locals  => {:foo => foo}
      rendered.should include(valid_nested_response_input)
      rendered.should include(valid_nested_response_javascript)
    end

    it "should handle current value for date" do
      render :inline => datepicker_form_template_current,:locals => {:foo => foo}
      rendered.should include( "value=\"#{current_value_date.strftime("%d/%m/%Y")}\"" )
    end

    it "should handle current value for time (12 hour + AM/PM)" do
      render :inline => datetimepicker_form_template_current_12,:locals => {:foo => foo}
      rendered.should include( "value=\"#{current_value.strftime("%d/%m/%Y %I:%M%P")}\"" )
    end

    it "should handle current value for time (24 hour)" do
      render :inline => datetimepicker_form_template_current_24,:locals => {:foo => foo}
      rendered.should include( "value=\"#{current_value.strftime("%d/%m/%Y %H:%M")}\"" )
    end

  end

  describe JqueryDatepicker::InstanceTag do
    it "should return a valid format when translating yy-mm-dd" do
      input_tag =  JqueryDatepicker::InstanceTag.new("test", "method", "aux")
      input_tag.translate_format("yy-mm-dd").should eq("%Y-%m-%d")
    end

    it "should return a valid format when translating mm-dd-yy" do
      input_tag =  JqueryDatepicker::InstanceTag.new("test", "method", "aux")
      input_tag.translate_format("mm-dd-yy").should eq("%m-%d-%Y")
    end

    it "should return a valid format when translating m-d-y" do
      input_tag =  JqueryDatepicker::InstanceTag.new("test", "method", "aux")
      input_tag.translate_format("m-d-y").should eq("%-m-%-d-%y")
    end

    it "should return a valid format when translating yy/m-dd" do
      input_tag =  JqueryDatepicker::InstanceTag.new("test", "method", "aux")
      input_tag.translate_format("yy/m-dd").should eq("%Y/%-m-%d")
    end
  end
end
