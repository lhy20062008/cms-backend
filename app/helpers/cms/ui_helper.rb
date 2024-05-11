module Cms
  module UiHelper
    def string_ui(options = {})
      options[:type] ||= 'string'
      options[:title] ||= I18n.t('title')
      options[:'x-decorator'] = options[:'x-decorator'] || options[:decorator] || 'FormItem'
      options[:'x-index'] ||= options.delete(:index) || 1
      %i[required visible disabled].each do |attribute|
        value = options[:"x-#{attribute}"] || options[attribute]
        options[:"x-#{attribute}"] = value unless value.nil?
      end

      options[:'x-component'] = options[:'x-component'] || options[:component] || 'Input'
      options[:'x-validator'] = options[:'x-validator'] || options[:validator] || []
      options
    end

    def color_ui(options = {})
      options[:type] ||= 'string'
      options[:title] ||= I18n.t('title')
      options[:'x-decorator'] = options[:'x-decorator'] || options[:decorator] || 'FormItem'
      options[:'x-index'] ||= options.delete(:index) || 1
      %i[required visible disabled].each do |attribute|
        value = options[:"x-#{attribute}"] || options[attribute]
        options[:"x-#{attribute}"] = value unless value.nil?
      end

      options[:'x-component'] = options[:'x-component'] || options[:component] || 'ColorPicker'
      options[:'x-validator'] = options[:'x-validator'] || options[:validator] || []
      options
    end

    def enum_ui(options = {})
      options[:type] ||= 'string'
      options[:title] ||= I18n.t('title')
      options[:'x-decorator'] = options[:'x-decorator'] || options[:decorator] || 'FormItem'
      options[:'x-index'] ||= options.delete(:index) || 1
      %i[required visible disabled].each do |attribute|
        value = options[:"x-#{attribute}"] || options[attribute]
        options[:"x-#{attribute}"] = value unless value.nil?
      end

      options[:'x-component'] = options[:'x-component'] || options[:component] || 'Select'
      options[:'x-component-props'] = {
        clearable: true,
        placeholder: options[:placeholder] || options[:title] || ''
      }
      options
    end

    def switch_ui(options = {})
      options[:type] = 'boolean'
      options[:title] ||= I18n.t('title')
      options[:'x-decorator'] = options[:'x-decorator'] || options[:decorator] || 'FormItem'
      options[:'x-index'] ||= options.delete(:index) || 1
      %i[required visible disabled].each do |attribute|
        value = options[:"x-#{attribute}"] || options[attribute]
        options[:"x-#{attribute}"] = value unless value.nil?
      end

      options[:'x-component'] = options[:'x-component'] || options[:component] || 'Switch'
      options[:'x-validator'] = options[:'x-validator'] || options[:validator] || []
      value = options.delete(:value)
      options[:'x-value'] = value.nil? ? true : value
      options
    end

    def number_ui(options = {})
      options[:type] = 'number'
      options[:title] ||= I18n.t('title')
      options[:'x-decorator'] = options[:'x-decorator'] || options[:decorator] || 'FormItem'
      options[:'x-index'] ||= options.delete(:index) || 1
      %i[required visible disabled].each do |attribute|
        value = options[:"x-#{attribute}"] || options[attribute]
        options[:"x-#{attribute}"] = value unless value.nil?
      end

      options[:'x-component'] = options[:'x-component'] || options[:component] || 'NumberPicker'
      options[:'x-validator'] = options[:'x-validator'] || options[:validator] || 'number'
      options
    end

    def datetime_range_ui(options = {})
      options[:type] = 'string'
      options[:title] ||= I18n.t('title')
      options[:'x-decorator'] = options[:'x-decorator'] || options[:decorator] || 'FormItem'
      options[:'x-index'] ||= options.delete(:index) || 1
      %i[required visible disabled].each do |attribute|
        value = options[:"x-#{attribute}"] || options[attribute]
        options[:"x-#{attribute}"] = value unless value.nil?
      end

      options[:'x-component'] = options[:'x-component'] || options[:component] || 'DatePicker'
      options[:'x-validator'] = options[:'x-validator'] || options[:validator] || []
      showTime = options.delete(:showTime)
      showTime = true if showTime.nil?
      options[:'x-component-props'] = {
        clearable: true,
        picker: 'date',
        showTime: showTime,
        valueFormat: options[:format] || 'yyyy-MM-dd HH:mm',
        startPlaceholder: 'Start Date',
        endPlaceholder: 'End Date',
        placeholder: 'Date Range',
        type: 'datetimerange'
      }
      options
    end

    def datetime_ui(options = {})
      options[:type] = 'string'
      options[:title] ||= I18n.t('title')
      options[:'x-decorator'] = options[:'x-decorator'] || options[:decorator] || 'FormItem'
      options[:'x-index'] ||= options.delete(:index) || 1
      %i[required visible disabled].each do |attribute|
        value = options[:"x-#{attribute}"] || options[attribute]
        options[:"x-#{attribute}"] = value unless value.nil?
      end

      options[:'x-component'] = options[:'x-component'] || options[:component] || 'DatePicker'
      options[:'x-validator'] = options[:'x-validator'] || options[:validator] || []
      showTime = options.delete(:showTime)
      showTime = true if showTime.nil?
      options[:'x-component-props'] = {
        picker: 'date',
        showTime: showTime,
        format: options[:format]
      }
      options
    end

    def images_ui(options = {})
      options[:type] = 'Array<object>'
      options[:title] ||= I18n.t('title')
      options[:'x-decorator'] = options[:'x-decorator'] || options[:decorator] || 'FormItem'
      options[:'x-index'] ||= options.delete(:index) || 1
      %i[required visible disabled].each do |attribute|
        value = options[:"x-#{attribute}"] || options[attribute]
        options[:"x-#{attribute}"] = value unless value.nil?
      end

      options[:'x-component'] = options[:'x-component'] || options[:component] || 'UploadImage'
      options[:'x-validator'] = options[:'x-validator'] || options[:validator] || []
      options[:'x-component-props'] = {
        action: '/cms/images',
        limit: options[:limit] || 10
      }
      options
    end

    def file_ui(options)
      options[:type] ||= 'string'
      options[:title] ||= I18n.t('title')
      options[:'x-decorator'] = options[:'x-decorator'] || options[:decorator] || 'FormItem'
      options[:'x-component'] = options[:'x-component'] || options[:component] || 'File'
      options[:'x-validator'] = options[:'x-validator'] || options[:validator] || []
      options[:'x-component-props'] = {
        accept: options[:accept].nil? ?  '.csv': options.delete(:accept),
        description: options[:description].nil? ? 'Only support .csv file' : options.delete(:description)
      }
      options
    end

    def fselect_ui(options)
      options[:type] ||= 'array'
      options[:title] ||= I18n.t('title')
      options[:'x-decorator'] = options[:'x-decorator'] || options[:decorator] || 'FormItem'
      options[:'x-index'] ||= options.delete(:index) || 1
      %i[required visible disabled value].each do |attribute|
        value = options[:"x-#{attribute}"] || options[attribute]
        options[:"x-#{attribute}"] = value unless value.nil?
      end

      options[:'x-component'] = options[:'x-component'] || options[:component] || 'FSelect'
      options[:'x-validator'] = options[:'x-validator'] || options[:validator] || []
      options[:'x-component-props'] = {
        multiple: options[:multiple].nil? ? true : options.delete(:multiple),
        remote: options[:remote].nil? ? true : options.delete(:remote),
        url: options.delete(:url) || 'cms/forms/simple_list',
        response_data_path: options.delete(:response_data_path) || 'data.objects',
        params: {resource: options.delete(:resource)}
      }
      options
    end

    def addition_ui
      {
        addition: {
          type: 'void',
          title: I18n.t('add'),
          'x-component': 'ArrayItems.Addition',
          'x-component-props': {},
          'x-index': 0
        }
      }
    end

    def remove_ui options = {}
      options[:type] = 'void'
      options[:'x-component'] = options[:'x-component'] || options[:component] || 'ArrayItems.Remove'
      options[:'x-index'] ||= options.delete(:index) || 1
      options
    end

    def sort_ui options = {}
      options[:type] = 'void'
      options[:'x-decorator'] = 'FormItem'
      options[:'x-component'] = 'ArrayItems.SortHandle'
      options[:'x-index'] ||= options.delete(:index) || 1
      options
    end

    def dependencies_for_ui dep
      {
        dependencies: [".#{dep}"],
        fulfill: {
          state: {
            visible: '{{$deps[0]}}'
          }
        }
      }
    end
    
    def undependencies_for_ui dep
      {
        dependencies: [".#{dep}"],
        fulfill: {
          state: {
            hidden: '{{$deps[0]}}'
          }
        }
      }
    end
  end
end
