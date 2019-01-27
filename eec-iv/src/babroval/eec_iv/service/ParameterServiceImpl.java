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
		Integer i = 0, j = 0;

		switch (parameterNumber) {
		case "1":
			i = Integer.parseInt(data.substring(0, 2), 16);
			j = Integer.parseInt("0" + data.substring(3, 4), 16);
			i = (i * 4) + (j * 1024);
			i = ((i + 5) / 10) * 10;
			value = String.valueOf(i);
			break;
		case "2":
			i = Integer.parseInt("0" + data.substring(19, 20), 16);
			System.out.println(i);
			j = Integer.parseInt("0" + data.substring(16, 17), 16);
			System.out.println(j);
			i = 128 - ((i * 16) + j);
			value = String.valueOf(i);
			break;
		case "3":
			i = Integer.parseInt(data.substring(8, 10), 16);
			j = 4 - Integer.parseInt("0" + data.substring(11, 12), 16);
			i = ((256 * j) - i) * 2675 / 1000;
			value = String.valueOf(i);
			break;
		case "4":
			if (data.substring(48, 52).equals("3090")) {
				value = "Opened";
			} else {
				value = "Closed";
			}
			break;
		case "5":
			i = Integer.parseInt(data.substring(32, 34), 16);
			i = i * 10 / 256;
			j = Integer.parseInt("0" + data.substring(35, 36), 16);
			if (j.equals(0) && i.equals(0)) {
				value = "0";
			} else if (j.equals(0) && !i.equals(0)) {
				value = String.valueOf(i) + "00";
			} else {
				value = String.valueOf(j) + String.valueOf(i) + "00";
			}
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
			value = data.substring(16, 20);
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
			value = data.substring(12, 16);
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
