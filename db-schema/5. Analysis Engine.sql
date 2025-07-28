-- Analysis jobs queue
CREATE TABLE analysis_jobs (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    project_id UUID NOT NULL REFERENCES projects(id) ON DELETE CASCADE,
    job_type analysis_job_type NOT NULL,
    priority job_priority DEFAULT 'normal',
    status job_status DEFAULT 'pending',
    progress INTEGER DEFAULT 0, -- 0-100
    config JSONB DEFAULT '{}',
    metadata JSONB DEFAULT '{}',
    scheduled_for TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    started_at TIMESTAMP,
    completed_at TIMESTAMP,
    error_message TEXT,
    retry_count INTEGER DEFAULT 0,
    max_retries INTEGER DEFAULT 3,
    created_by UUID REFERENCES users(id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TYPE analysis_job_type AS ENUM ('full_analysis', 'incremental_analysis', 'security_scan', 'quality_check', 'performance_analysis');
CREATE TYPE job_priority AS ENUM ('low', 'normal', 'high', 'urgent');
CREATE TYPE job_status AS ENUM ('pending', 'running', 'completed', 'failed', 'canceled', 'timeout');

-- Analysis results
CREATE TABLE analysis_results (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    project_id UUID NOT NULL REFERENCES projects(id) ON DELETE CASCADE,
    job_id UUID NOT NULL REFERENCES analysis_jobs(id) ON DELETE CASCADE,
    file_path TEXT NOT NULL,
    language VARCHAR(50),
    analysis_type analysis_type NOT NULL,
    engine_name VARCHAR(100) NOT NULL,
    engine_version VARCHAR(50),
    started_at TIMESTAMP NOT NULL,
    completed_at TIMESTAMP NOT NULL,
    execution_time_ms INTEGER NOT NULL,
    results JSONB NOT NULL DEFAULT '{}',
    metadata JSONB DEFAULT '{}',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TYPE analysis_type AS ENUM ('static_analysis', 'security_scan', 'ai_review', 'performance_check', 'quality_metrics');

-- Issues found during analysis
CREATE TABLE analysis_issues (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    analysis_result_id UUID NOT NULL REFERENCES analysis_results(id) ON DELETE CASCADE,
    project_id UUID NOT NULL REFERENCES projects(id) ON DELETE CASCADE,
    file_path TEXT NOT NULL,
    rule_id VARCHAR(100) NOT NULL,
    rule_name VARCHAR(255) NOT NULL,
    severity issue_severity NOT NULL,
    category issue_category NOT NULL,
    type issue_type NOT NULL,
    message TEXT NOT NULL,
    description TEXT,
    line_start INTEGER,
    line_end INTEGER,
    column_start INTEGER,
    column_end INTEGER,
    code_snippet TEXT,
    suggestion TEXT,
    fix_available BOOLEAN DEFAULT FALSE,
    auto_fixable BOOLEAN DEFAULT FALSE,
    confidence DECIMAL(3,2) DEFAULT 1.0,
    effort_minutes INTEGER,
    external_references JSONB DEFAULT '{}',
    status issue_status DEFAULT 'open',
    resolved_by UUID REFERENCES users(id),
    resolved_at TIMESTAMP,
    resolution_note TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TYPE issue_severity AS ENUM ('critical', 'high', 'medium', 'low', 'info');
CREATE TYPE issue_category AS ENUM ('security', 'performance', 'maintainability', 'reliability', 'style', 'documentation');
CREATE TYPE issue_type AS ENUM ('bug', 'vulnerability', 'code_smell', 'duplication', 'performance_issue', 'style_violation');
CREATE TYPE issue_status AS ENUM ('open', 'acknowledged', 'resolved', 'false_positive', 'wont_fix');