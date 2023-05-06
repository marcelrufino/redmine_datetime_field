module RedmineDatetimeField
    module QueryPatch
        def self.included(base)            
            base.class_eval do
                unloadable
                self.operators_by_filter_type[:datetime] = [ "=", ">=", "<=", "><", "<t+", ">t+", "><t+", "t+", "nd", "t", "ld", "nw", "w", "lw", "l2w", "nm", "m", "lm", "y", ">t-", "<t-", "><t-", "t-", "!*", "*" ]
            end # do
        end # def
    end # module
end # module

unless Query.included_modules.include?(RedmineDatetimeField::QueryPatch)
  Query.send(:include, RedmineDatetimeField::QueryPatch)
end