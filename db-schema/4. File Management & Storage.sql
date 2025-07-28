-- File storage records
CREATE TABLE file_storage (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    project_id UUID NOT NULL REFERENCES projects(id) ON DELETE CASCADE,
    file_path TEXT NOT NULL,
    file_name VARCHAR(255) NOT NULL,
    file_size BIGINT NOT NULL,
    file_hash VARCHAR(64) NOT NULL, -- SHA-256 hash for deduplication
    mime_type VARCHAR(100),
    storage_provider storage_provider DEFAULT 'local',
    storage_path TEXT NOT NULL,
    storage_url TEXT,
    version_id VARCHAR(50),
    metadata JSONB DEFAULT '{}',
    uploaded_by UUID REFERENCES users(id),
    uploaded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    last_accessed TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    access_count INTEGER DEFAULT 0,
    is_deleted BOOLEAN DEFAULT FALSE,
    deleted_at TIMESTAMP
);

CREATE TYPE storage_provider AS ENUM ('local', 'gcs', 's3', 'azure');

-- File versions for version control
CREATE TABLE file_versions (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    file_storage_id UUID NOT NULL REFERENCES file_storage(id) ON DELETE CASCADE,
    version_number INTEGER NOT NULL,
    file_hash VARCHAR(64) NOT NULL,
    file_size BIGINT NOT NULL,
    storage_path TEXT NOT NULL,
    change_type version_change_type DEFAULT 'modified',
    commit_hash VARCHAR(40),
    branch_name VARCHAR(100),
    created_by UUID REFERENCES users(id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(file_storage_id, version_number)
);

CREATE TYPE version_change_type AS ENUM ('added', 'modified', 'deleted', 'renamed');