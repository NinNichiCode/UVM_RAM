class ram_coverage extends uvm_subscriber #(ram_item);
   `uvm_component_utils(ram_coverage)

   ram_item trans;

 covergroup cov_inst;
    option.per_instance = 1;

    // 1. Kiểm tra lệnh Write/Read
    CP_WR: coverpoint trans.kind {
        bins write = {1};
        bins read  = {0};
    }

    // 2. Kiểm tra Địa chỉ (Vì chỉ có 16 ô, ta nên hit hết từng ô)
    CP_ADDR: coverpoint trans.addr {
        bins all_addresses[] = {[0:15]}; // Tạo 16 bins cho 16 địa chỉ
    }

    // 3. Kiểm tra Dữ liệu vào
    CP_DIN: coverpoint trans.din {
        bins corners[] = {8'h00, 8'hFF, 8'hAA, 8'h55};
        bins ranges[4] = {[0:255]};
    }

    // 4. Kiểm tra Chuyển đổi lệnh (Bus turnaround)
    CP_WR_RD_TRANS: coverpoint trans.kind {
        bins wr_to_rd = (1 => 0);
        bins rd_to_wr = (0 => 1);
    }

    // 5. Cross Coverage (QUAN TRỌNG NHẤT CHO RAM)
    // Đảm bảo mọi địa chỉ đều được Ghi ít nhất 1 lần và Đọc ít nhất 1 lần
    X_ADDR_WR: cross CP_ADDR, CP_WR {
        // Bin này sẽ yêu cầu 16 địa chỉ x 2 lệnh = 32 kịch bản
        option.weight = 10; // Tăng trọng số cho mục này
    }

    // 6. Cross nâng cao (Tùy chọn)
    // Đảm bảo đã từng ghi dữ liệu cực đại/cực tiểu vào RAM
    X_DIN_WR: cross CP_DIN, CP_WR {
        ignore_bins read_mode = binsof(CP_WR) intersect {0};
    }

endgroup

   function new(string name = "ram_coverage", uvm_component parent = null);
      super.new(name, parent);
      cov_inst = new();
   endfunction

   virtual function void write(ram_item t);
       trans = t;
       cov_inst.sample();
   endfunction
endclass
