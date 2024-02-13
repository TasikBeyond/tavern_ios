import Foundation
import Combine
import ClientApi

class CreatureDetailsViewModel: ObservableObject {
  @Published var content: CompendiumContentResponseModel
  @Published var creature: CreatureResponseModel?
  
  private var cancellables = Set<AnyCancellable>()
  
  init(content: CompendiumContentResponseModel) {
    self.content = content
    fetchCreature(creatureId: content.id)
  }
  
  private func fetchCreature(creatureId: UUID) {
    Pigeon.CreatureApi.getCreatureById(creatureId: content.id) { data in
      self.creature = data;
    } failure: { error in
      print(error)
    }
  }
}

