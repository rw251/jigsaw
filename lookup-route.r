message('# Route lookup')
message('Creates a dataframe `RouteLookup` with columns:')
message('  - RouteDescription - route description from data')
message('  - RouteCategory - oral/injection/sublingual/topical/rectal')
message('Example output:')
message('  | RouteDescription       | RouteCategory |')
message('  | ---------------------- | ------------- |')
message('  | IV Continuous Infusion | injection     |')
message('  | Enteral Feeding Tube   | oral          |\n')

# create the route lookup
RouteLookup <- data.frame()
 
# Build up the lookup. Columns are:
# - RouteInstruction
# - RouteCategory (oral/injection/sublingual/topical/rectal)

# Injection
rbind(RouteLookup,c("EPIDURAL Infusion.","injection")) -> RouteLookup
rbind(RouteLookup,c("EPIDURAL Injection.","injection")) -> RouteLookup
rbind(RouteLookup,c("IM","injection")) -> RouteLookup
rbind(RouteLookup,c("INTRATHECAL  Injection","injection")) -> RouteLookup
rbind(RouteLookup,c("IV Continuous Infusion","injection")) -> RouteLookup
rbind(RouteLookup,c("IV Infusion","injection")) -> RouteLookup
rbind(RouteLookup,c("IV Slow Injection","injection")) -> RouteLookup
rbind(RouteLookup,c("Intrathecal","injection")) -> RouteLookup
rbind(RouteLookup,c("SC","injection")) -> RouteLookup
rbind(RouteLookup,c("SC Continuous Infusion","injection")) -> RouteLookup

# Oral
rbind(RouteLookup,c("Enteral Feeding Tube","oral")) -> RouteLookup
rbind(RouteLookup,c("Oral","oral")) -> RouteLookup
rbind(RouteLookup,c("Oral/IM","oral")) -> RouteLookup

# Sublingual
rbind(RouteLookup,c("Sublingual","sublingual")) -> RouteLookup

# Topical
rbind(RouteLookup,c("Topical","topical")) -> RouteLookup

colnames(RouteLookup) <- c("RouteDescription","RouteCategory")
RouteLookup$RouteCategory <- as.factor(RouteLookup$RouteCategory)
