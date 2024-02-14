import Foundation
import Combine
import ClientApi

class CreatureDetailsViewModel: ObservableObject {
  @Published var content: CompendiumContentResponseModel
  @Published var creature: CreatureResponseModel?
  @Published var isLoading = false

  
  private var cancellables = Set<AnyCancellable>()
  
  init(content: CompendiumContentResponseModel) {
    self.content = content
    fetchCreature(creatureId: content.id)
  }
  
  private func fetchCreature(creatureId: UUID) {
    self.isLoading = true
    Pigeon.CreatureApi.getCreatureById(creatureId: content.id) { data in
      DispatchQueue.main.async {
        self.creature = data
        self.isLoading = false
      }
    } failure: { error in
      DispatchQueue.main.async {
        print(error)
        self.isLoading = false
      }
    }
  }
}

