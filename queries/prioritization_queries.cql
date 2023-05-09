// First Query To Prioritize Product Gaps By Account Factors
// Add a variable to store the desired salesRegion
// dersiredSalesRegion can be "AMER", "APAC", "C&A", "EMEA", "Inside Sales", "Public Sector"
// WITH "Public Sector" AS desiredSalesRegion

// Match Product Gaps, Account Gaps, and Accounts
MATCH (pg:ProductGap)-[:HAS_ACCOUNT_GAP]->(ag:AccountGap)-[:IMPACTS]->(a:Account)
// ag.type can be 'Account Challenge', 'Account Breaker', 'Nice to Have
WHERE ag.type IN ['Account Challenge', 'Account Breaker', 'Nice to Have']
// pg.status can be 'Done', 'In Progress', 'In Roadmap (12+ months)', 'In Roadmap (3+ months)', 'In Roadmap (6+ months)', 'Needs More Justification', 'Researching', 'Unassigned', 'Will Not Pursue
AND pg.status IN ['Done', 'In Progress', 'In Roadmap (12+ months)', 'In Roadmap (3+ months)', 'In Roadmap (6+ months)', 'Needs More Justification', 'Researching', 'Unassigned', 'Will Not Pursue']
// AND a.salesRegion = desiredSalesRegion
WITH pg, ag, a

// Match Secondary Gaps (other Account Gaps) associated with the same Account
MATCH (a)-[:HAS_ACCOUNT_GAP]->(sg:AccountGap)<-[:HAS_ACCOUNT_GAP]-(spg:ProductGap)
WHERE sg.type = 'Account Challenge' OR sg.type = 'Account Breaker'
// spg.status can be 'Done', 'In Progress', 'In Roadmap (12+ months)', 'In Roadmap (3+ months)', 'In Roadmap (6+ months)', 'Needs More Justification', 'Researching', 'Unassigned', 'Will Not Pursue
AND spg.status IN ['In Progress', 'In Roadmap (12+ months)', 'In Roadmap (3+ months)', 'In Roadmap (6+ months)', 'Needs More Justification', 'Researching', 'Unassigned']
WITH pg, ag, a, COUNT(DISTINCT sg) AS SecondaryGapsCount

// Calculate AccountRevenue, Weight, and AccountGapsCount
WITH pg, a, 
    ag.amount AS AccountRevenue, 
    COUNT(DISTINCT ag) AS AccountGapsCount, 
    CASE ag.type 
        WHEN 'Account Challenge' THEN 0.6
        WHEN 'Account Breaker' THEN 1
        ELSE 0.25 
    END AS Weight, 
    SecondaryGapsCount

// Calculate WeightedAccountRevenue, AccountCount, TotalSecondaryGapsCount, and TotalAccountRevenue
WITH pg, 
    SUM(AccountRevenue * Weight) AS WeightedAccountRevenue, 
    COUNT(DISTINCT a) AS AccountCount, 
    SUM(SecondaryGapsCount) AS TotalSecondaryGapsCount, 
    SUM(AccountRevenue) AS TotalAccountRevenue

// Return Product Gap, Status, TotalAccountRevenue, TotalWeightedAccountRevenue, AccountCount, WeightedScore, and AvgSecondaryGapsCount
RETURN pg.id AS ProductGap, 
    pg.status AS Status, 
    pg.name AS ProductGapName, 
    TotalAccountRevenue, 
    WeightedAccountRevenue AS TotalWeightedAccountRevenue, 
    AccountCount, 
    WeightedAccountRevenue * AccountCount / (1.0 + (TotalSecondaryGapsCount * 1.0)) AS WeightedScore, 
    TotalSecondaryGapsCount * 1.0 / AccountCount AS AvgSecondaryGapsCount
ORDER BY WeightedScore DESC

// Second Query To Prioritize Product Gaps By Opportunity Factors
// Add a variable to store the desired salesRegion
// WITH "AMER" AS desiredSalesRegion

// Match Product Gaps, Opportunity Gaps, Opportunities, and Accounts
MATCH (pg:ProductGap)-[:HAS_OPPORTUNITY_GAP]->(og:OpportunityGap)-[:IMPACTS]-(o:Opportunity)<-[:HAS_OPPORTUNITY]-(a:Account)
WHERE og.type IN ['Account Challenge', 'Account Breaker', 'Nice to Have']
AND pg.status IN ['Done', 'In Progress', 'In Roadmap (12+ months)', 'In Roadmap (3+ months)', 'In Roadmap (6+ months)', 'Needs More Justification', 'Researching', 'Unassigned', 'Will Not Pursue']
// AND a.salesRegion = desiredSalesRegion
WITH pg, og, o, a

// Match Secondary Opportunities associated with the same Account
MATCH (a)-[:HAS_OPPORTUNITY]-(so:Opportunity)
WITH pg, og, o, a, so

// Use OPTIONAL MATCH for Secondary Gaps (other Opportunity Gaps) associated with the Secondary Opportunities
OPTIONAL MATCH (so)<-[:IMPACTS]-(sg:OpportunityGap)<-[:HAS_OPPORTUNITY_GAP]-(spg:ProductGap)
WHERE sg.type = 'Deal Challenge' OR sg.type = 'Deal Breaker'
AND spg.status IN ['In Progress', 'In Roadmap (12+ months)', 'In Roadmap (3+ months)', 'In Roadmap (6+ months)', 'Needs More Justification', 'Researching', 'Unassigned']
WITH pg, og, o, a, COUNT(DISTINCT so) AS SecOppsCount, COUNT(DISTINCT sg) AS SecondaryGapsCount

// Calculate OpportunityRevenue, Weight, and OpportunityGapsCount
WITH pg, o, a, SecOppsCount, SecondaryGapsCount,
    og.amount AS OpportunityRevenue,
    COUNT(DISTINCT og) AS OpportunityGapsCount,
    CASE og.type
        WHEN 'Account Challenge' THEN 0.6 * og.amount
        WHEN 'Account Breaker' THEN og.amount
        ELSE 0.25 * og.amount
    END AS WeightedRevenue

// Calculate WeightedOpportunityRevenue, OpportunityCount, TotalSecondaryGapsCount, and TotalOpportunityRevenue
WITH pg,
    TotalWeightedOpportunityRevenue,
    COUNT(DISTINCT o) AS OpportunityCount,
    SUM(SecondaryGapsCount) AS TotalSecondaryGapsCount,
    SUM(OpportunityRevenue) AS TotalOpportunityRevenue

// Return Product Gap, Status, TotalOpportunityRevenue, TotalWeightedOpportunityRevenue, OpportunityCount, WeightedScore, and AvgSecondaryGapsCount
RETURN pg.id AS ProductGap,
    pg.status AS Status,
    pg.name AS ProductGapName,
    TotalOpportunityRevenue,
    TotalWeightedOpportunityRevenue,
    OpportunityCount,
    TotalWeightedOpportunityRevenue * OpportunityCount / (1.0 + (TotalSecondaryGapsCount * 1.0 / OpportunityCount)) AS WeightedScore,
    TotalSecondaryGapsCount * 1.0 / OpportunityCount AS AvgSecondaryGapsCount
ORDER BY WeightedScore DESC