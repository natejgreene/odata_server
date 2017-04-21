module OData
  module ActiveRecordSchema
    class Property < OData::AbstractSchema::Property
      cattr_reader :column_adapter_return_types
      @@column_adapter_return_types = {
        :binary    => 'Edm.Binary',
        :boolean   => 'Edm.Boolean',
        :byte      => 'Edm.Byte',
        :date      => 'Edm.DateTime',
        :datetime  => 'Edm.DateTime',
        :float     => 'Edm.Decimal',
        :decimal   => 'Edm.Decimal',
        :integer   => 'Edm.Int32',
        :string    => 'Edm.String',
        :text      => 'Edm.String',
        :timestamp => 'Edm.DateTime',
        :time      => 'Edm.Time'
      }.freeze

      def self.return_type_for(column_adapter)
        @@column_adapter_return_types[column_adapter.type] || 'Edm.String'
      end

      def self.name_for(column_adapter)
        column_adapter.name.to_s
      end

      def self.nullable?(column_adapter)
        column_adapter.null
      end

      attr_reader :column_adapter

      def initialize(schema, entity_type, column_adapter)
        super(schema, entity_type, self.class.name_for(column_adapter), self.class.return_type_for(column_adapter), self.class.nullable?(column_adapter))

        @column_adapter = column_adapter
      end

      def value_for(one)
        v = one.send(@column_adapter.name.to_sym)
        return v.to_datetime.strftime('%Y-%m-%dT%H:%M:%S') if v.class == ActiveSupport::TimeWithZone
        return "0" if return_type == 'Edm.Decimal' && v.nil?
        return v.to_s if return_type == 'Edm.Decimal'
        return v.to_s if return_type == 'Edm.String'
        v.respond_to?(:iso8601) ? v.send(:iso8601) : v
      end
    end
  end
end
