-- Projects
CREATE TABLE projects (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    organization_id UUID NOT NULL REFERENCES organizations(id) ON DELETE CASCADE,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    repository_url TEXT,
    default_branch VARCHAR(100) DEFAULT 'main',
    programming_languages TEXT[] DEFAULT '{}',
    framework_type VARCHAR(50),
    visibility project_visibility DEFAULT 'private',
    status project_status DEFAULT 'active',
    settings JSONB DEFAULT '{}',
    analysis_config JSONB DEFAULT '{}',
    created_by UUID NOT NULL REFERENCES users(id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    last_analyzed TIMESTAMP,
    analysis_count INTEGER DEFAULT 0
);

CREATE TYPE project_visibility AS ENUM ('public', 'private', 'internal');
CREATE TYPE project_status AS ENUM ('active', 'archived', 'deleted');

-- Project collaborators
CREATE TABLE project_collaborators (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    project_id UUID NOT NULL REFERENCES projects(id) ON DELETE CASCADE,
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    role collaborator_role DEFAULT 'viewer',
    added_by UUID REFERENCES users(id),
    added_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(project_id, user_id)
);

CREATE TYPE collaborator_role AS ENUM ('owner', 'admin', 'developer', 'viewer');

-- Project statistics
CREATE TABLE project_statistics (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    project_id UUID NOT NULL REFERENCES projects(id) ON DELETE CASCADE,
    date DATE NOT NULL,
    total_files INTEGER DEFAULT 0,
    total_lines INTEGER DEFAULT 0,
    total_issues INTEGER DEFAULT 0,
    critical_issues INTEGER DEFAULT 0,
    high_issues INTEGER DEFAULT 0,
    medium_issues INTEGER DEFAULT 0,
    low_issues INTEGER DEFAULT 0,
    security_issues INTEGER DEFAULT 0,
    performance_issues INTEGER DEFAULT 0,
    maintainability_score DECIMAL(3,2),
    reliability_score DECIMAL(3,2),
    security_score DECIMAL(3,2),
    test_coverage DECIMAL(5,2),
    technical_debt_minutes INTEGER DEFAULT 0,
    duplicated_lines INTEGER DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(project_id, date)
);