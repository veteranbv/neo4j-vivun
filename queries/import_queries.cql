// -- Importing data from accgap-prodgap.csv
LOAD CSV WITH HEADERS FROM 'file:///accgap-prodgap.csv' AS row
MERGE (pg:ProductGap {id: row.`Product Gap: ID`, name: row.`Product Gap: Product Gap Name`, status: row.Status})
MERGE (a:Account {id: row.`Account: Account ID (Long)`, name: row.`Account: Account Name`, salesRegion: row.`Account: Sales Region (TVP)`, geoRegion: row.`Account: Geo Region`, subRegion: row.`Account: Sub-Region`})
MERGE (ag:AccountGap {id: row.`Account Gap: ID`, number: row.`Account Gap: Account Gap Number`, amount: toFloat(row.`Account Gap Amount (converted)`), type: row.Type})
MERGE (pg)-[:HAS_ACCOUNT_GAP]->(ag)
MERGE (a)-[:HAS_ACCOUNT_GAP]->(ag)
MERGE (ag)-[:IMPACTS]->(a)

// -- Importing data from oppgap-prodgap.csv
LOAD CSV WITH HEADERS FROM 'file:///oppgap-prodgap.csv' AS row
MERGE (pg:ProductGap {id: row.`Product Gap: ID`, name: row.`Product Gap: Product Gap Name`, status: row.Status})
MERGE (og:OpportunityGap {id: row.`Opportunity Gap: ID`, number: row.`Opportunity Gap: Opportunity Gap Number`, amount: toFloat(row.`Opportunity Gap Amount (converted)`), type: row.Type, currency: row.`Opportunity Gap Amount (converted) Currency`})
MERGE (o:Opportunity {id: row.`Opportunity: Opportunity ID`, name: row.`Opportunity: Opportunity Name`, salesRegion: row.`Opportunity: Sales Region (TVP)`, geoRegion: row.`Opportunity: Geo Region`, subRegion: row.`Opportunity: Sub-Region`})
MERGE (a:Account {id: row.`Opportunity: Account ID (Long)`, name: row.`Opportunity: Account Name`, salesRegion: row.`Opportunity: Sales Region (TVP)`, geoRegion: row.`Opportunity: Geo Region`, subRegion: row.`Opportunity: Sub-Region`})
MERGE (pg)-[:HAS_OPPORTUNITY_GAP]->(og)
MERGE (a)-[:HAS_OPPORTUNITY_GAP]->(og)
MERGE (og)-[:IMPACTS]->(o)
MERGE (a)-[:HAS_OPPORTUNITY]->(o)
