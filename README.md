# Neo4j Vivun Project

![Neo4j Vivun Project](/images/Product%20Gaps%20-%20Visualized.jpg)
Product Gaps Visualized

## Project Overview

This project leverages Neo4j to analyze and prioritize product gaps based on their association with accounts and opportunities, ultimately guiding engineering development efforts. By importing data from two CSV files exported from SFDC and Vivun Hero, accgap-prodgap.csv for account-product gap relationships and oppgap-prodgap.csv for opportunity-product gap relationships, the project aims to scrutinize these associations to effectively prioritize product gaps and inform strategic decision-making.

## Objectives

1. Import the data from the CSV files into the Neo4j database.
2. Analyze the data to understand the relationships between product gaps, accounts, and opportunities.
3. Prioritize product gaps based on various factors, such as revenue, customer count, and associated secondary gaps.
4. Provide insights that help in making informed decisions about addressing product gaps and understanding their impact on customers.

## Workflow

1. Data Import: Use Cypher queries to import data from the CSV files into the Neo4j database.
2. Data Analysis: Run analytics queries to analyze the data and understand the relationships between product gaps, accounts, and opportunities.
3. Prioritization: Run prioritization queries to calculate weighted scores for product gaps and sort them based on these scores.
4. Insights and Recommendations: Use the results from the analysis and prioritization queries to make informed decisions about addressing product gaps and understanding their impact on customers.

## Project Structure

- `data`: This folder contains the CSV files for importing data into the Neo4j database.
- `queries`: This folder contains Cypher queries for importing data, analyzing the data, and prioritizing product gaps.
- `documentation`: This folder may contain other documentation and approaches.

## Install

Installing Neo4j is not very difficult, and the process should be relatively straightforward if you follow the official documentation. Here are the general steps to install Neo4j on different platforms:

1. Windows:
   - Download the Neo4j Community Edition Windows installer from the official website (<https://neo4j.com/download/>).
   - Run the installer, follow the on-screen instructions, and choose the installation directory.
   - Once installed, you can start the Neo4j server using the desktop application or command prompt.

2. macOS (method I used):
   - The easiest way to install Neo4j on macOS is using Homebrew. If you don't have Homebrew installed, you can follow the instructions on the official Homebrew website (<https://brew.sh/>).
   - Once you have Homebrew installed, run the following command in your terminal to install Neo4j: `brew install neo4j`
   - After installation, you can start the Neo4j server using the following command: `neo4j start`

3. Linux (Debian/Ubuntu):
   - Import the Neo4j signing key by running: `wget -O - https://debian.neo4j.com/neotechnology.gpg.key | sudo apt-key add -`
   - Add the Neo4j repository: `echo 'deb https://debian.neo4j.com stable latest' | sudo tee -a /etc/apt/sources.list.d/neo4j.list`
   - Update the package list: `sudo apt-get update`
   - Install Neo4j: `sudo apt-get install neo4j`
   - Start the Neo4j server with: `sudo service neo4j start`

4. Linux (RHEL/CentOS/Fedora):
   - Download the RPM package for Neo4j from the official website (<https://neo4j.com/download/>).
   - Install the package using the following command (replacing the package name with the appropriate version): `sudo yum install neo4j-<version>.rpm`
   - Start the Neo4j server with: `sudo systemctl start neo4j`

5. Docker:
   - If you have Docker installed, you can run Neo4j in a container. Pull the latest Neo4j image using: `docker pull neo4j`
   - Run the container with: `docker run --name neo4j -p7474:7474 -p7687:7687 -v $HOME/neo4j/data:/data -v $HOME/neo4j/logs:/logs neo4j`

You may receive an error message you are encountering indicates that there is an unrecognized setting in the `neo4j.conf` configuration file. The setting in question is `wrapper.java.additional.4`. This issue may arise if there have been changes to the configuration file or if there are deprecated settings in the file.

To resolve this issue, you can try the following:

**Disable strict validation:** As suggested in the error message, you can disable strict validation of the configuration settings by adding the following line to your `neo4j.conf` file:

```bash
server.config.strict_validation.enabled=false
```

This will allow Neo4j to start even if there are unrecognized settings in the configuration file.

After making this change, try starting Neo4j again with the `neo4j start` command. If the issue persists or you encounter further errors, please check the Neo4j documentation and ensure that your configuration file is set up correctly for the version of Neo4j you are using.

Once you have installed and started Neo4j, you can access its web interface by navigating to `http://localhost:7474` in your web browser. The default username is "neo4j", and you'll be prompted to set a new password upon the first login.

## Connect

Make sure you are providing the correct credentials when connecting to the Neo4j server. Follow these steps:

1. Click on the "Connect URL" field and make sure it is set to the correct URL for your local Neo4j server, usually: `neo4j://localhost:7687`.

2. Leave the "Database" field empty for the default database.

3. Make sure the "Authentication type" is set to "Username / Password."

4. In the "Username" field, enter the correct Neo4j username (usually "neo4j" by default).

5. In the "Password" field, enter the correct password. If you have not changed the default password, it should be "neo4j" as well. However, you will be prompted to change the default password on the first connection.

6. Click the "Connect" button to establish the connection to the Neo4j server.

## Getting Started

1. Copy the data into the Neo4j import directory by running something similar to the following:

    ```bash
    cp ~/projects/neo4j-vivun/data/accgap-prodgap.csv /opt/homebrew/Cellar/neo4j/5.6.0/libexec/import/
    cp ~/projects/neo4j-vivun/data/oppgap-prodgap.csv /opt/homebrew/Cellar/neo4j/5.6.0/libexec/import/
    ```

2. Run the Cypher queries to import the data into the Neo4j database.
3. Run the analytics and prioritization queries to analyze the data and prioritize product gaps.

## Graph Data Model

This data model contains two datasets, one for Account Gaps and another for Opportunity Gaps, with a focus on Product Gaps. The datasets are imported into the graph database using two separate Cypher queries.

### Data Dictionary

#### Fields in accgap-prodgap.csv

| Field                                   | Description                                                | Data Type |
|-----------------------------------------|------------------------------------------------------------|-----------|
| Product Gap: Product Gap Name           | Product gap name                                           | String    |
| Product Gap: ID                         | Product gap unique identifier                              | String    |
| Account Gap: Account Gap Number         | Account gap number - short form                            | String    |
| Account Gap: ID                         | Account gap unique identifier                              | String    |
| Account: Account Name                   | Account name                                               | String    |
| Account: Account ID (Long)              | Account unique identifier                                  | String    |
| Account: Parent Account ID              | Parent account ID associated with the Account              | String    |
| Account Gap Amount (converted) Currency | Account value currency                                     | String    |
| Account Gap Amount (converted)          | Account value                                              | Float     |
| Type                                    | Account gap priority                                       | String    |
| Status                                  | Product gap development status                             | String    |
| Account: Sales Region (TVP)             | Which theater owns the Account                             | String    |
| Account: Geo Region                     | Which geographic region is the Account in                  | String    |
| Account: Sub-Region                     | Which sub-region in the theater owns the Account           | String    |

#### Fields in oppgap-prodgap.csv

| Field                                   | Description                                                | Data Type |
|-----------------------------------------|------------------------------------------------------------|-----------|
| Product Gap: Product Gap Name           | Product gap name                                           | String    |
| Product Gap: ID                         | Product gap unique identifier                              | String    |
| Opportunity Gap: Opportunity Gap Number | Opportunity gap number - short form                        | String    |
| Opportunity Gap: ID                     | Opportunity gap unique identifier                          | String    |
| Opportunity: Opportunity Name           | Opportunity name                                           | String    |
| Opportunity: Opportunity ID             | Opportunity unique identifier                              | String    |
| Opportunity: Account Name               | Account name associated with the opportunity               | String    |
| Opportunity: Account ID (Long)          | Account unique identifier                                  | String    |
| Opportunity Gap Amount (converted) Currency | Opportunity value currency                               | String    |
| Opportunity Gap Amount (converted)      | Opportunity value                                          | Float     |
| Type                                    | Opportunity gap priority                                   | String    |
| Status                                  | Product gap development status                             | String    |
| Opportunity: Sales Region (TVP)         | Which theater owns the opportunity                         | String    |
| Opportunity: Geo Region                 | Which geographic region is the opportunity in              | String    |
| Opportunity: Sub-Region                 | Which sub-region in the theater owns the opportunity       | String    |

#### Unique Values

Here are the unique values formatted for your data dictionary:

##### Account Gap: Type

- Account Challenge
- Account Breaker
- Nice to Have

##### Opp Gap: Type

- Deal Breaker
- Deal Challenge
- Nice to Have

##### Status

- Done
- In Progress
- In Roadmap (12+ months)
- In Roadmap (3+ months)
- In Roadmap (6+ months)
- Needs More Justification
- Researching
- Unassigned
- Will Not Pursue

##### Account: Sales Region (TVP)

- AMER
- APAC
- C&A
- EMEA
- Inside Sales
- Public Sector

##### Account: Geo Region

- AFRICA
- ANZ
- ASEAN
- CEMEA
- GREATER CHINA
- INDIA
- JAPAN
- KOREA
- LATAM
- MEDI
- Middle East
- N AMERICA
- NEMEA
- SEMEA

##### Account: Sub-Region

- Alliance
- AMER
- AMER Inside Sales
- APAC
- APAC Inside Sales
- CEMEA
- CIV/SLED
- DOD/IC
- EMEA
- EMEA Inside Sales
- Emerging Markets
- LATAM
- MEDI
- NA Central
- NA East
- NA West
- NEMEA
- Public Sector

### Nodes and Properties

1. There are five node types: Product Gap, Account Gap, Account, Opportunity Gap, and Opportunity.
2. Connections can exist between a Product Gap and an Account Gap, a Product Gap and an Opportunity Gap, an Account and an Account Gap, and an Opportunity and an Opportunity Gap.
3. There are no direct connections between Opportunity Gaps and Account Gaps. However, they are both Accounts and are related to Product Gaps.

To model this graph, you can create the five node types with their respective properties and relationships between them. The structure would look like this:

- Account: A node representing an account with properties like ID, name, sales region, geo region, and sub-region. It can have Account Gaps.
- Opportunity Gap: A node representing a feature request or product enhancement at the Opportunity level. It has properties like ID, number, type, amount, currency, and can be linked to a Product Gap.
- Opportunity: A node representing an opportunity with properties like ID, name, sales region, geo region, and sub-region. It can have Opportunity Gaps.

#### Nodes

1. ProductGap
    - Description:
        - A node representing a feature or group of features that are missing in the product set.
    - Properties:
        - id: Product gap unique identifier
        - name: Product gap name
        - status: Product gap development status

2. AccountGap
    - Description:
        - A node representing a feature request or product enhancement at the Account level.
    - Properties:
        - id: Account gap unique identifier
        - number: Account gap number
        - amount: Account gap value
        - type: Account gap priority

3. Account
    - Description:
        - A node representing an account.
    - Properties:
        - id: Account unique identifier
        - name: Account name
        - salesRegion: Sales region (theater)
        - geoRegion: Geographic region
        - subRegion: Sub-region

4. OpportunityGap
    - Description:
        - A node representing a feature request or product enhancement at the Opportunity level.
    - Properties:
        - id: Opportunity gap unique identifier
        - number: Opportunity gap number
        - amount: Opportunity gap value
        - type: Opportunity gap priority
        - currency: Opportunity gap value currency

5. Opportunity
    - Description:
        - A node representing an opportunity.
    - Properties:
        - id: Opportunity unique identifier
        - name: Opportunity name
        - salesRegion: Sales region (theater)
        - geoRegion: Geographic region
        - subRegion: Sub-region

#### Relationships

1. ProductGap -[:HAS_ACCOUNT_GAP]-> AccountGap
2. Account -[:HAS_ACCOUNT_GAP]-> AccountGap
3. AccountGap -[:IMPACTS]-> Account
4. ProductGap -[:HAS_OPPORTUNITY_GAP]-> OpportunityGap
5. Opportunity -[:HAS_OPPORTUNITY_GAP]-> OpportunityGap
6. OpportunityGap -[:IMPACTS]-> Opportunity
7. Account -[:HAS_OPPORTUNITY]-> Opportunity

### Consideration of Secondary Gaps in Prioritization

In the context of prioritizing product gaps, it is essential to consider not only the direct impact of the primary product gaps but also the combined impact of other related product gaps, referred to as secondary gaps, that are associated with the same account. Secondary gaps are other product gaps that are connected to the account through account gaps, similar to the primary product gap.

The rationale behind this approach is that if you prioritize engineering work to address a primary product gap with the aim of unblocking selling and growth activity in an account, but the account is still hindered by multiple other product gaps (secondary gaps), then the original work might not have the intended effect of unblocking the account.

By considering the overall impact of all related product gaps (primary and secondary) on the accounts, you can make a more informed decision on which engineering work would be most effective in unblocking the accounts and fostering growth. This prioritization method enables a comprehensive understanding of the account's needs and ensures that resources are allocated efficiently to address the most impactful product gaps.

### Import Queries

#### Importing data from accgap-prodgap.csv

```CQL
LOAD CSV WITH HEADERS FROM 'file:///accgap-prodgap.csv' AS row
MERGE (pg:ProductGap {id: row.`Product Gap: ID`, name: row.`Product Gap: Product Gap Name`, status: row.Status})
MERGE (a:Account {id: row.`Account: Account ID (Long)`, name: row.`Account: Account Name`, salesRegion: row.`Account: Sales Region (TVP)`, geoRegion: row.`Account: Geo Region`, subRegion: row.`Account: Sub-Region`})
MERGE (ag:AccountGap {id: row.`Account Gap: ID`, number: row.`Account Gap: Account Gap Number`, amount: toFloat(row.`Account Gap Amount (converted)`), type: row.Type})
MERGE (pg)-[:HAS_ACCOUNT_GAP]->(ag)
MERGE (a)-[:HAS_ACCOUNT_GAP]->(ag)
MERGE (ag)-[:IMPACTS]->(a)
```

#### Importing data from oppgap-prodgap.csv

```CQL
LOAD CSV WITH HEADERS FROM 'file:///oppgap-prodgap.csv' AS row
MERGE (pg:ProductGap {id: row.`Product Gap: ID`, name: row.`Product Gap: Product Gap Name`, status: row.Status})
MERGE (og:OpportunityGap {id: row.`Opportunity Gap: ID`, number: row.`Opportunity Gap: Opportunity Gap Number`, amount: toFloat(row.`Opportunity Gap Amount (converted)`), type: row.Type, currency: row.`Opportunity Gap Amount (converted) Currency`})
MERGE (o:Opportunity {id: row.`Opportunity: Opportunity ID`, name: row.`Opportunity: Opportunity Name`, salesRegion: row.`Opportunity: Sales Region (TVP)`, geoRegion: row.`Opportunity: Geo Region`, subRegion: row.`Opportunity: Sub-Region`})
MERGE (a:Account {id: row.`Opportunity: Account ID (Long)`, name: row.`Opportunity: Account Name`})
MERGE (pg)-[:HAS_OPPORTUNITY_GAP]->(og)
MERGE (a)-[:HAS_OPPORTUNITY_GAP]->(og)
MERGE (og)-[:IMPACTS]->(o)
MERGE (a)-[:HAS_OPPORTUNITY]->(o)
```

These two import queries, along with the nodes, properties, and relationships described above, create a comprehensive data model that connects Account nodes to both AccountGap and OpportunityGap nodes through IMPACTS relationships. The data model also connects ProductGap nodes to AccountGap and OpportunityGap nodes through HAS_*_GAP relationships. This structure allows you to analyze the relationships between accounts, product gaps, and opportunity/account gaps for better decision-making and insights. With this graph model, you can perform various analyses and queries, such as finding the most impactful Product Gaps or the most common Opportunity Gaps among Accounts.

## Directory Tree

```bash
neo4j-vivun
├── README.md
├── data
│   ├── accgap-prodgap.csv
│   └── oppgap-prodgap.csv
├── documentation
│   └── alternative_approaches.md
├── images
│   └── Product Gaps - Visualized.jpg
├── queries
│   ├── analytics_queries.cql
│   ├── import_queries.cql
│   └── prioritization_queries.cql
└── scripts
    └── automation_script.py
```

## Prioritization Queries

### Note the weighted revenue is arbitrarily set as follows

- Nice to Have is revenue * 0.25
- Account Challenge: 0.6
- Account Breaker: 1

### For Account Gap Prioritization Queries

1. A query that prioritizes product gaps based on the total account revenue amount for each product gap.
    - Nodes: ProductGap, AccountGap, Account
    - Relationships: HAS_ACCOUNT_GAP, IMPACTS
    - Properties: amount (AccountGap), type (AccountGap)
    - Output: Product Gap, Status, Account Gap, Type, Account Revenue, Weighted Account Revenue (based on gap type and account revenue) desc, Account Count

    ```CQL
    // Match ProductGaps, AccountGaps, and Accounts with the specified properties
    MATCH (pg:ProductGap)-[:HAS_ACCOUNT_GAP]->(ag:AccountGap)-[:IMPACTS]->(a:Account)
    WHERE ag.type IN ['Account Challenge', 'Account Breaker', 'Nice to Have']
    AND pg.status IN ['Done', 'In Progress', 'In Roadmap (12+ months)', 'In Roadmap (3+ months)', 'In Roadmap (6+ months)', 'Needs More Justification', 'Researching', 'Unassigned', 'Will Not Pursue']

    // Calculate the weight based on the ag.type
    WITH pg, ag, a,
        CASE ag.type
            WHEN 'Account Challenge' THEN 0.6
            WHEN 'Account Breaker' THEN 1
            ELSE 0.25
        END as weight

    // Calculate the weightedAccountRevenue
    WITH pg, a, ag, weight * ag.amount as weightedAccountRevenue

    // Aggregate data and perform calculations
    WITH pg.name as ProductGap, pg.status as Status, sum(weightedAccountRevenue) as WeightedAccountRevenue, sum(ag.amount) as AccountRevenue, count(DISTINCT a) as AccountCount

    // Return the desired data
    RETURN ProductGap, Status, AccountRevenue, WeightedAccountRevenue, AccountCount
    ORDER BY WeightedAccountRevenue DESC
    ```

2. A query that prioritizes product gaps based on the total number of accounts impacted by each product gap
    - Nodes: ProductGap, AccountGap, Account
    - Relationships: HAS_ACCOUNT_GAP, IMPACTS
    - Properties: amount (AccountGap), type (AccountGap)
    - Output: Product Gap, Status, Account Gap, Type, Account Revenue, Weighted Account Revenue (based on gap type and account revenue), Account Count desc

    ```CQL
    // Match ProductGaps, AccountGaps, and Accounts with the specified properties
    MATCH (pg:ProductGap)-[:HAS_ACCOUNT_GAP]->(ag:AccountGap)-[:IMPACTS]->(a:Account)
    WHERE ag.type IN ['Account Challenge', 'Account Breaker', 'Nice to Have']
    AND pg.status IN ['Done', 'In Progress', 'In Roadmap (12+ months)', 'In Roadmap (3+ months)', 'In Roadmap (6+ months)', 'Needs More Justification', 'Researching', 'Unassigned', 'Will Not Pursue']

    // Calculate the weight based on the ag.type
    WITH pg, ag, a,
        CASE ag.type
            WHEN 'Account Challenge' THEN 0.6
            WHEN 'Account Breaker' THEN 1
            ELSE 0.25
        END as weight

    // Calculate the weightedAccountRevenue
    WITH pg, a, ag, weight * ag.amount as weightedAccountRevenue

    // Aggregate data and perform calculations
    WITH pg.name as ProductGap, pg.status as Status, sum(weightedAccountRevenue) as WeightedAccountRevenue, sum(ag.amount) as AccountRevenue, count(DISTINCT a) as AccountCount

    // Return the desired data
    RETURN ProductGap, Status, AccountRevenue, WeightedAccountRevenue, AccountCount
    ORDER BY AccountCount DESC
    ```

3. A query that prioritizes product gaps based on the account revenue and the number of accounts impacted.
    - Nodes: ProductGap, AccountGap, Account
    - Relationships: HAS_ACCOUNT_GAP, IMPACTS
    - Properties: amount (AccountGap), type (AccountGap)
    - Output: Product Gap, Status, Account Gap, Type, Account Revenue, Weighted Account Revenue (based on gap type and account revenue), Account Count, Weighted Score (based on weighted account revenue * account count) desc

    ```CQL
    // Match ProductGaps, AccountGaps, and Accounts with the specified properties
    MATCH (pg:ProductGap)-[:HAS_ACCOUNT_GAP]->(ag:AccountGap)-[:IMPACTS]->(a:Account)
    WHERE ag.type IN ['Account Challenge', 'Account Breaker', 'Nice to Have']
    AND pg.status IN ['Done', 'In Progress', 'In Roadmap (12+ months)', 'In Roadmap (3+ months)', 'In Roadmap (6+ months)', 'Needs More Justification', 'Researching', 'Unassigned', 'Will Not Pursue']

    // Calculate the weightedAccountRevenue based on the ag.type
    WITH pg, ag, a,
        CASE ag.type
        WHEN 'Nice to Have' THEN 0.25 * ag.amount
        WHEN 'Account Challenge' THEN 0.6 * ag.amount
        WHEN 'Account Breaker' THEN 1 * ag.amount
        ELSE 0
        END as weightedAccountRevenue

    // Return the desired data and perform calculations
    RETURN pg.id as ProductGap,
        pg.status as Status,
        pg.name as ProductGapName,
        ag.type as AccountGapType,
        SUM(ag.amount) as AccountRevenue,
        SUM(weightedAccountRevenue) as WeightedAccountRevenue,
        COUNT(DISTINCT a) as AccountCount,
        SUM(weightedAccountRevenue) * COUNT(DISTINCT a) as WeightedScore
    ORDER BY WeightedScore DESC
    ```

4. A query that prioritizes product gaps based on a weighted score that accounts for account revenue, the number of accounts impacted, and the presence of high priority secondary gaps attached to the associated accounts.
    - Nodes: ProductGap, AccountGap, Account, SecondaryGap (which is just an alias for other AccountGaps associated with the Account)
    - Relationships: HAS_ACCOUNT_GAP, IMPACTS
    - Properties: amount (AccountGap), type (AccountGap)
    - Output: Product Gap, Status, Total Associate Account Revenue, Total Assoicated Weighted Account Revenue (based on gap type and account revenue), To Number of Associated Accounts, Weighted Score (based on weighted account revenue * account count / (1 + average of the count of secondary gaps of associated accounts)), the average of the count of secondary gaps of associated accounts,  sort by desc by Weighted Score

    ```CQL
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
    ```

    - Visualize

        ```CQL
        MATCH (pg:ProductGap)-[:HAS_ACCOUNT_GAP]->(ag:AccountGap)-[:IMPACTS]->(a:Account)
        RETURN pg, ag, a
        ```

### For Opportunity Gaps Prioritization Queries

1. A query that prioritizes product gaps based on the total opportunity revenue amount for each product gap.
    - Nodes: ProductGap, OpportunityGap, Opportunity
    - Relationships: HAS_OPPORTUNITY_GAP, IMPACTS
    - Properties: amount (OpportunityGap), type (OpportunityGap)
    - Output: Product Gap, Status, Opportunity Gap, Type, Opportunity Revenue, Weighted Opportunity Revenue (based on gap type and opportunity revenue) desc, Opportunity Count

    ```CQL
    MATCH (pg:ProductGap)-[:HAS_OPPORTUNITY_GAP]->(og:OpportunityGap)-[:IMPACTS]->(o:Opportunity)
    WHERE og.type IN ['Opportunity Challenge', 'Opportunity Breaker', 'Nice to Have']
    AND pg.status IN ['Done', 'In Progress', 'In Roadmap (12+ months)', 'In Roadmap (3+ months)', 'In Roadmap (6+ months)', 'Needs More Justification', 'Researching', 'Unassigned', 'Will Not Pursue']

    WITH pg, og, o,
        CASE og.type
            WHEN 'Opportunity Challenge' THEN 0.6
            WHEN 'Opportunity Breaker' THEN 1
            ELSE 0.25
        END as weight

    WITH pg, o, og, weight * og.amount as weightedOpportunityRevenue

    WITH pg.name as ProductGap, pg.status as Status, sum(weightedOpportunityRevenue) as WeightedOpportunityRevenue, sum(og.amount) as OpportunityRevenue, count(DISTINCT o) as OpportunityCount

    RETURN ProductGap, Status, OpportunityRevenue, WeightedOpportunityRevenue, OpportunityCount
    ORDER BY WeightedOpportunityRevenue DESC
    ```

2. A query that prioritizes product gaps based on the total number of opportunities impacted by each product gap.
    - Nodes: ProductGap, OpportunityGap, Opportunity
    - Relationships: HAS_OPPORTUNITY_GAP, IMPACTS
    - Properties: amount (OpportunityGap), type (OpportunityGap)
    - Output: Product Gap, Status, Opportunity Gap, Type, Opportunity Revenue, Weighted Opportunity Revenue (based on gap type and opportunity revenue), Opportunity Count desc

    ```CQL
    MATCH (pg:ProductGap)-[:HAS_OPPORTUNITY_GAP]->(og:OpportunityGap)-[:IMPACTS]->(o:Opportunity)
    WHERE og.type IN ['Opportunity Challenge', 'Opportunity Breaker', 'Nice to Have']
    AND pg.status IN ['Done', 'In Progress', 'In Roadmap (12+ months)', 'In Roadmap (3+ months)', 'In Roadmap (6+ months)', 'Needs More Justification', 'Researching', 'Unassigned', 'Will Not Pursue']

    WITH pg, og, o,
        CASE og.type
            WHEN 'Opportunity Challenge' THEN 0.6
            WHEN 'Opportunity Breaker' THEN 1
            ELSE 0.25
        END as weight

    WITH pg, o, og, weight * og.amount as weightedOpportunityRevenue

    WITH pg.name as ProductGap, pg.status as Status, sum(weightedOpportunityRevenue) as WeightedOpportunityRevenue, sum(og.amount) as OpportunityRevenue, count(DISTINCT o) as OpportunityCount

    RETURN ProductGap, Status, OpportunityRevenue, WeightedOpportunityRevenue, OpportunityCount
    ORDER BY OpportunityCount DESC
    ```

3. A query that prioritizes product gaps based on opportunity revenue and the number of opportunities impacted.
    - Nodes: ProductGap, OpportunityGap, Opportunity
    - Relationships: HAS_OPPORTUNITY_GAP, IMPACTS
    - Properties: amount (OpportunityGap), type (OpportunityGap)
    - Output: Product Gap, Status, Opportunity Gap, Type, Opportunity Revenue, Weighted Opportunity Revenue (based on gap type and opportunity revenue), Opportunity Count, Weighted Score (based on weighted opportunity revenue * opportunity count) desc

    ```CQL
    MATCH (pg:ProductGap)-[:HAS_OPPORTUNITY_GAP]->(og:OpportunityGap)-[:IMPACTS]->(o:Opportunity)
    WHERE og.type IN ['Opportunity Challenge', 'Opportunity Breaker', 'Nice to Have']
    AND pg.status IN ['Done', 'In Progress', 'In Roadmap (12+ months)', 'In Roadmap (3+ months)', 'In Roadmap (6+ months)', 'Needs More Justification', 'Researching', 'Unassigned', 'Will Not Pursue']

    WITH pg, og, o,
        CASE og.type
            WHEN 'Nice to Have' THEN 0.25 * og.amount
            WHEN 'Opportunity Challenge' THEN 0.6 * og.amount
            WHEN 'Opportunity Breaker' THEN 1 * og.amount
            ELSE 0
        END as weightedOpportunityRevenue

    RETURN pg.id as ProductGap,
        pg.status as Status,
        pg.name as ProductGapName,
        og.type as OpportunityGapType,
        SUM(og.amount) as OpportunityRevenue,
        SUM(weightedOpportunityRevenue) as WeightedOpportunityRevenue,
        COUNT(DISTINCT o) as OpportunityCount,
        SUM(weightedOpportunityRevenue) * COUNT(DISTINCT o) as WeightedScore
    ORDER BY WeightedScore DESC
    ```

4. A query that prioritizes product gaps based on a weighted score that accounts for opportunity revenue, the number of opportunities impacted, and the presence of high priority secondary gaps attached to the associated opportunities.
    - Nodes: ProductGap, OpportunityGap, Opportunity
    - Relationships: HAS_OPPORTUNITY_GAP, IMPACTS
    - Properties: amount (OpportunityGap), type (OpportunityGap)
    - Product Gap, Status, Total Associate Opportunity Revenue, Total Assoicated Weighted Opportunity Revenue (based on gap type and opportunity revenue), To Number of Associated Opportunities, Weighted Score (based on weighted opportunity revenue * opportunity count / (1 + average of the count of secondary gaps of associated opporunities)), the average of the count of secondary gaps of associated opportunities,  sort by desc by Weighted Score

    ```CQL
    // Match Product Gaps, Opportunity Gaps, Opportunities, and Accounts
    MATCH (pg:ProductGap)-[:HAS_OPPORTUNITY_GAP]->(og:OpportunityGap)-[:IMPACTS]-(o:Opportunity)<-[:HAS_OPPORTUNITY]-(a:Account)
    WHERE og.type IN ['Account Challenge', 'Account Breaker', 'Nice to Have']
    AND pg.status IN ['Done', 'In Progress', 'In Roadmap (12+ months)', 'In Roadmap (3+ months)', 'In Roadmap (6+ months)', 'Needs More Justification', 'Researching', 'Unassigned', 'Will Not Pursue']
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
        SUM(WeightedRevenue) AS WeightedOpportunityRevenue,
        COUNT(DISTINCT o) AS OpportunityCount,
        SUM(SecondaryGapsCount) AS TotalSecondaryGapsCount,
        SUM(OpportunityRevenue) AS TotalOpportunityRevenue

    // Return Product Gap, Status, TotalOpportunityRevenue, TotalWeightedOpportunityRevenue, OpportunityCount, WeightedScore, and AvgSecondaryGapsCount
    RETURN pg.id AS ProductGap,
        pg.status AS Status,
        pg.name AS ProductGapName,
        TotalOpportunityRevenue,
        WeightedOpportunityRevenue AS TotalWeightedOpportunityRevenue,
        OpportunityCount,
        WeightedOpportunityRevenue * OpportunityCount / (1.0 + (TotalSecondaryGapsCount * 1.0 / OpportunityCount)) AS WeightedScore,
        TotalSecondaryGapsCount * 1.0 / OpportunityCount AS AvgSecondaryGapsCount
    ORDER BY WeightedScore DESC
    ```

    - Visualize

        ```CQL
        MATCH (pg:ProductGap)-[:HAS_OPPORTUNITY_GAP]->(og:OpportunityGap)-[:IMPACTS]-(o:Opportunity)<-[:HAS_OPPORTUNITY]-(a:Account)
        RETURN pg, og, o, a
        ```

### For Combined Account and Opportunity Gaps Prioritization Queries

1. A query that prioritizes product gaps based using a weighted score for each product gap, accounting for account revenue, the number of accounts impacted, opportunity revenue, the number of opportunities impacted, and the presence of high priority secondary gaps attached to the associated accounts and opportunities.
    - Nodes: ProductGap, AccountGap, Account, OpportunityGap, Opportunity
    - Relationships: HAS_ACCOUNT_GAP, IMPACTS, HAS_OPPORTUNITY_GAP
    - Properties: amount (AccountGap), type (AccountGap), amount (OpportunityGap), type (OpportunityGap)
    - Output: Product Gap, Status, Account Gap, Type, Account Revenue, Weighted Account Revenue (based on gap type and account revenue), Account Count, Opportunity Gap, Type, Opportunity Revenue, Weighted Opportunity Revenue (based on gap type and opportunity revenue), Opportunity Count, Weighted Score (based on weighted account revenue *account count* weighted opportunity revenue * opportunity count / 1 + average secondary gap presence) desc

    ```CQL
    // Match Product Gaps, Account Gaps, Accounts, and Opportunities
    Query Research In Progress
    ```
