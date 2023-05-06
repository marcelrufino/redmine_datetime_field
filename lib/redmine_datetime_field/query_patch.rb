module RedmineDatetimeField
    module QueryPatch
        def self.included(base)
            base.send(:include, InstanceMethods)
            
            base.class_eval do
                unloadable
                logger.info "**** PASSOU AQUI ****"
                self.operators_by_filter_type << :datetime => [ "=", ">=", "<=", "><", "<t+", ">t+", "><t+", "t+", "nd", "t", "ld", "nw", "w", "lw", "l2w", "nm", "m", "lm", "y", ">t-", "<t-", "><t-", "t-", "!*", "*" ]
            end # do
        end # def
    end # module
end # module