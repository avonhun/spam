import IdentityLookup

final class MessageFilterExtension: ILMessageFilterExtension, ILMessageFilterQueryHandling {
    func handle(_ queryRequest: ILMessageFilterQueryRequest,
                context: ILMessageFilterExtensionContext,
                completion: @escaping (ILMessageFilterQueryResponse) -> Void) {
        let response = ILMessageFilterQueryResponse()
        response.action = PoliticalSpamClassifier.isPoliticalSpam(queryRequest.messageBody ?? "")
            ? .junk : .none
        completion(response)
    }
}
