import '../../domain/entities/home_data_entity.dart';
import '../../domain/repositories/home_repository.dart';
import '../models/home_data_model.dart';

class HomeRepositoryImpl implements HomeRepository {
  @override
  Future<List<HomeDataEntity>> fetchItems() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return const [
      HomeDataModel(
        id: '1',
        title: 'Pix Recebido - Empresa X',
        description: 'Pagamento de Salário',
        amount: 5450.00,
        date: 'Hoje, 09:30',
        isIncome: true,
        category: 'Salário',
      ),
      HomeDataModel(
        id: '2',
        title: 'Supermercado Extra',
        description: 'Compra no cartão de débito',
        amount: 342.80,
        date: 'Hoje, 14:15',
        isIncome: false,
        category: 'Alimentação',
      ),
      HomeDataModel(
        id: '3',
        title: 'Pix Enviado - João Silva',
        description: 'Transferência instantânea',
        amount: 120.00,
        date: 'Ontem, 19:40',
        isIncome: false,
        category: 'Transferência',
      ),
      HomeDataModel(
        id: '4',
        title: 'Assinatura Netflix',
        description: 'Pagamento recorrente',
        amount: 55.90,
        date: '17 Ago',
        isIncome: false,
        category: 'Entretenimento',
      ),
      HomeDataModel(
        id: '5',
        title: 'Posto Shell',
        description: 'Combustível',
        amount: 210.00,
        date: '16 Ago',
        isIncome: false,
        category: 'Transporte',
      ),
      HomeDataModel(
        id: '6',
        title: 'Rendimento RP Invest',
        description: 'Dividendos de investimentos',
        amount: 87.45,
        date: '15 Ago',
        isIncome: true,
        category: 'Investimentos',
      ),
      HomeDataModel(
        id: '7',
        title: 'Farmácia Raia',
        description: 'Medicamentos',
        amount: 89.90,
        date: '14 Ago',
        isIncome: false,
        category: 'Saúde',
      ),
      HomeDataModel(
        id: '8',
        title: 'Restaurante OutBack',
        description: 'Jantar em família',
        amount: 275.50,
        date: '12 Ago',
        isIncome: false,
        category: 'Alimentação',
      ),
      HomeDataModel(
        id: '9',
        title: 'Reembolso iFood',
        description: 'Estorno de pedido',
        amount: 45.00,
        date: '10 Ago',
        isIncome: true,
        category: 'Estorno',
      ),
      HomeDataModel(
        id: '10',
        title: 'Uber Trips',
        description: 'Viagem de aplicativo',
        amount: 32.60,
        date: '08 Ago',
        isIncome: false,
        category: 'Transporte',
      ),
      HomeDataModel(
        id: '11',
        title: 'Livraria Cultura',
        description: 'Livros e materiais',
        amount: 140.00,
        date: '05 Ago',
        isIncome: false,
        category: 'Educação',
      ),
    ];
  }
}
