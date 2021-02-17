package babroval.eec_iv.service;

import java.io.InputStream;
import java.util.List;

import babroval.eec_iv.dao.Dao;
import babroval.eec_iv.dao.ParameterDaoImpl;
import babroval.eec_iv.model.Parameter;

public class ParameterServiceImpl implements Service<Parameter> {

	private Dao<Parameter> dao = new ParameterDaoImpl();

	@Override
	public List<Parameter> getAll(InputStream csvFile) {
		return dao.loadAll(csvFile);
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
		String temp = "";
		Integer i = 0, j = 0, k = 0;

		switch (parameterNumber) {
		case "1":
			i = Integer.parseInt(data.substring(0, 2), 16);
			j = Integer.parseInt("0" + data.substring(3, 4), 16);
			i = i * 4 + j * 1024;
			i = ((i + 5) / 10) * 10;
			value = String.valueOf(i);
			break;
		case "2":
			i = Integer.parseInt("0" + data.substring(16, 17), 16);
			j = Integer.parseInt("0" + data.substring(19, 20), 16);
			i = 128 - (j * 16 + i);
			value = String.valueOf(i);
			break;
		case "3":
			i = Integer.parseInt(data.substring(8, 10), 16);
			j = 4 - Integer.parseInt("0" + data.substring(11, 12), 16);
			i = (256 * j - i) * 2675 / 1000;
			value = String.valueOf(i);
			break;
		case "4":
			temp = data.substring(48, 52);
			if (temp.equals("3090")) {
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
			i = Integer.parseInt(data.substring(36, 38), 16);
			j = Integer.parseInt("0" + data.substring(39, 40), 16);
			i = ((256 * j + i) - (256 * j + i) / 24) * 80;
			value = String.valueOf(i);
			break;
		case "7":
			i = Integer.parseInt(data.substring(12, 14), 16);
			j = Integer.parseInt("0" + data.substring(15, 16), 16);
			k = (256 * j + i) * 5 / 200;
			i = ((256 * j + i) - k) * 5;
			value = String.valueOf(i);
			break;
		case "8":
			temp = data.substring(44, 46);
			if (temp.equals("FF")) {
				value = "Closed";
			} else if (temp.equals("00")) {
				value = "Part. Opened";
			} else if (temp.equals("01")) {
				value = "Fully Opened";
			}
			break;
		case "9":
			i = Integer.parseInt(data.substring(40, 42), 16) / 4;
			value = String.valueOf(i);
			break;
		case "10":
			i = Integer.parseInt("0" + data.substring(4, 5), 16);
			j = Integer.parseInt("0" + data.substring(5, 6), 16);
			j = j * 10 / 16;
			value = String.valueOf(i) + "." + String.valueOf(j);
			break;
		case "11":
			i = Integer.parseInt(data.substring(20, 22), 16);
			i = (i - 16) / 10 + i - 15;
			value = String.valueOf(i);
			break;
		case "12":
			i = Integer.parseInt(data.substring(24, 26), 16);
			i = (i - 16) / 10 + i - 15;
			value = String.valueOf(i);
			break;
		case "13":
			i = Integer.parseInt("0" + data.substring(28, 29), 16);
			j = Integer.parseInt("0" + data.substring(31, 32), 16);
			i = (((15 * j) + i) * 80 + 45 * j) / 100;
			value = String.valueOf(i);
			break;
		case "14":
			temp = data.substring(52, 56);
			if (temp.equals("1380") | temp.equals("1290") | temp.equals("32B0")) {
				value = "High";
			} else {
				value = "Low";
			}
			break;
		case "15":
			temp = data.substring(56, 60);
			if (temp.equals("80EC")) {
				value = "Opened";
			} else {
				value = "Closed";
			}
			break;
		case "16":
			temp = data.substring(56, 60);
			if (temp.equals("0028") | temp.equals("80A8") | temp.equals("2008") | temp.equals("A088")) {
				value = "N or P";
			} else if (temp.equals("4068") | temp.equals("C0E8") | temp.equals("6048") | temp.equals("E0C8")) {
				value = "D or R";
			}
			break;
		case "17":
			temp = data.substring(56, 60);
			if (temp.equals("0028") | temp.equals("80A8") | temp.equals("4068") | temp.equals("C0E8")) {
				value = "Released";
			} else if (temp.equals("2008") | temp.equals("A088") | temp.equals("6048") | temp.equals("E0C8")) {
				value = "Pressed";
			}
			break;
		default:
			throw new RuntimeException("incorrect data");
		}
		return value;
	}
}
