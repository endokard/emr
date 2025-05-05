-- Party is a main table for organizations and persons
CREATE TABLE party (
    id UUID PRIMARY KEY,
    type VARCHAR(20), -- person or organization
    date_created TIMESTAMP DEFAULT now()
);

-- Table for identity (Name, surname, sex)
CREATE TABLE party_identity (
    id UUID PRIMARY KEY,
    party_id UUID REFERENCES party(id) ON DELETE CASCADE,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    middle_name VARCHAR(100),
    date_of_birth DATE,
    sex CHAR(1),
	prefix VARCHAR(100) --(Dr., Prof.)
);

-- Contact data (Phone, mail ...)
CREATE TABLE contact (
    id UUID PRIMARY KEY,
    party_id UUID REFERENCES party(id) ON DELETE CASCADE,
    type VARCHAR(20), --Phone, mail, fax
    value TEXT --+37125633698, test@test.com
);

-- Pearson roles (patient, doctor, admin ...)
CREATE TABLE role (
    id UUID PRIMARY KEY,
    party_id UUID REFERENCES party(id) ON DELETE CASCADE,
    role_name VARCHAR(50), --Nurse, doctor, admin
    organization VARCHAR(100)
);

-- Pearson identifying documents (Passport, ID card, social security number and etc.)
CREATE TABLE identifier (
    id UUID PRIMARY KEY,
    party_id UUID REFERENCES party(id) ON DELETE CASCADE,
    id_type VARCHAR(50), --Pasport, ID
    id_value VARCHAR(100)
);

-- Relations between persons
CREATE TABLE party_relationship (
    id UUID PRIMARY KEY,
    source_party_id UUID REFERENCES party(id) ON DELETE CASCADE,
    target_party_id UUID REFERENCES party(id) ON DELETE CASCADE,
    relationship_type VARCHAR(50) CHECK (relationship_type IN ('TREATS', 'EMPLOYED_BY', 'IS_RELATED_TO'))
);
