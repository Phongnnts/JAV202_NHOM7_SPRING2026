package entity;

public enum BillStatus {
    NEW("Chờ xử lý"),
    CONFIRMED("Đã xác nhận"),
    DONE("Hoàn thành");

    private final String displayName;

    BillStatus(String displayName) {
        this.displayName = displayName;
    }

    public String getDisplayName() {
        return displayName;
    }
}