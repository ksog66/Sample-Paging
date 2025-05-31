package com.kklabs.sharedpagination.data.local

enum class UploadStatus(val value: String) {
    IN_PROGRESS("in_progress"),
    SUCCESSFUL("successful"),
    FAILED("failed");
    companion object {
        fun fromString(s: String?): UploadStatus? {
            return values().firstOrNull { it.value.equals(s, true) }
        }
    }
}