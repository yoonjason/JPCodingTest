import Foundation

enum TypeEnum: String, Codable {
    case info = "INFO"
    case review = "REVIEW"
}

enum CellType: String, Codable {
    case cellTypeCompany = "CELL_TYPE_COMPANY"
    case cellTypeHorizontalTheme = "CELL_TYPE_HORIZONTAL_THEME"
    case cellTypeReview = "CELL_TYPE_REVIEW"
}



// MARK: -- BaseModel
struct BaseModel: Codable {
    let minimumInterviews, totalPage, minimumReviews, totalCount: Int
    let items: [Item]
    let page, pageSize, minimumSalaries: Int

    enum CodingKeys: String, CodingKey {
        case minimumInterviews = "minimum_interviews"
        case totalPage = "total_page"
        case minimumReviews = "minimum_reviews"
        case totalCount = "total_count"
        case items, page
        case pageSize = "page_size"
        case minimumSalaries = "minimum_salaries"
    }
}

// MARK: - Item
struct Item: Codable {
    let ranking: Int?
    let cellType: CellType
    let interviewDifficulty: Double?
    let name: String?
    let salaryAvg: Int?
    let webSite: String?
    let logoPath: String?
    let interviewQuestion: String?
    let companyID: Int?
    let hasJobPosting: String?
    let rateTotalAvg: Double?
    let industryID: Int?
    let reviewSummary: String?
    let type: TypeEnum?
    let industryName, simpleDesc: String?
    let count: Int?
    let themes: [Theme]?
    let cons: String?
    let daysAgo: Int?
    let pros, occupationName, date: String?
    let smb: SMB?

    enum CodingKeys: String, CodingKey {
        case ranking
        case cellType = "cell_type"
        case interviewDifficulty = "interview_difficulty"
        case name
        case salaryAvg = "salary_avg"
        case webSite = "web_site"
        case logoPath = "logo_path"
        case interviewQuestion = "interview_question"
        case companyID = "company_id"
        case hasJobPosting = "has_job_posting"
        case rateTotalAvg = "rate_total_avg"
        case industryID = "industry_id"
        case reviewSummary = "review_summary"
        case type
        case industryName = "industry_name"
        case simpleDesc = "simple_desc"
        case count, themes, cons
        case daysAgo = "days_ago"
        case pros
        case occupationName = "occupation_name"
        case date, smb
    }
}


// MARK: - SMB
struct SMB: Codable {
}

// MARK: - Theme
struct Theme: Codable {
    let color: String
    let coverImage: String
    let id: Int
    let title: String

    enum CodingKeys: String, CodingKey {
        case color
        case coverImage = "cover_image"
        case id, title
    }
}

