import PostgreSQLProvider
import SendGridProvider

extension Config {
    public func setup() throws {
        // allow fuzzy conversions for these types
        // (add your own types here)
        Node.fuzzy = [Row.self, JSON.self, Node.self]
        try setupProviders()
        try setupPreparations()
    }
    
    /// Configure providers
    private func setupProviders() throws {
        try addProvider(PostgreSQLProvider.Provider.self)
        try addProvider(SendGridProvider.Provider.self)
    }
    
    /// Add all models that should have their
    /// schemas prepared before the app boots
    private func setupPreparations() throws {
        preparations.append(User.self)
        preparations.append(UserActicode.self)
        preparations.append(UserToken.self)
        preparations.append(PriceUnit.self)
        preparations.append(BookClassify.self)
        preparations.append(Book.self)
        preparations.append(Collect.self)
        preparations.append(Friend.self)
        preparations.append(Comment.self)
    }
}
