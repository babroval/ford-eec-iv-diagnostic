package babroval.eec_iv.service;

import java.util.List;

import babroval.eec_iv.dao.Dao;
import babroval.eec_iv.dao.ParameterDaoImpl;
import babroval.eec_iv.model.Parameter;

public class ParameterServiceImpl implements Service<Parameter> {

	private Dao<Parameter> dao = new ParameterDaoImpl();

	@Override
	public List<Parameter> getAll(String csvFilePath) {
		return dao.loadAll(csvFilePath);
	}

	@Override
	public List<Parameter> updateAll(List<Parameter> list, StringBuffer data) {
		for (Parameter entity : list) {
			String value = setValue(entity.getNumber(), data);
			entity.setValue(value);
		}
		return list;
	}

	private static String setValue(String parameterNumber, StringBuffer data) {

		String value = "";
		switch (parameterNumber) {
		case "1":
			value = data.substring(0, 4);
			break;
		case "2":
			value = data.substring(4, 8);
			break;
		case "3":
			value = data.substring(8, 12);
			break;
		case "4":
			value = data.substring(12, 16);
			break;
		case "5":
			value = data.substring(16, 20);
			break;
		case "6":
			value = data.substring(20, 24);
			break;
		case "7":
			value = data.substring(24, 28);
			break;
		case "8":
			value = data.substring(28, 32);
			break;
		case "9":
			value = data.substring(32, 36);
			break;
		case "10":
			value = data.substring(36, 40);
			break;
		case "11":
			value = data.substring(40, 44);
			break;
		case "12":
			value = data.substring(44, 48);
			break;
		case "13":
			value = data.substring(48, 52);
			break;
		case "14":
			value = data.substring(52, 56);
			break;
		case "15":
			value = data.substring(56, 60);
			break;
		case "16":
			value = data.substring(60, 64);
			break;
		case "17":
			value = data.substring(60, 64);
			break;
		default:
			throw new RuntimeException("incorrect data");
		}
		return value;
	}
}
